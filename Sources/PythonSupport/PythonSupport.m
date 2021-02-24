//
//  PythonSupport.m
//
//  Copyright (c) 2021 Changbeom Ahn
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Python.h>
#include <dlfcn.h>

#import "PythonSupport.h"

static void load_custom_builtin_importer(void);

@implementation Python

- (instancetype)initWithArgc:(int)argc argv:(const char *)argv
{
    self = [super init];
    
    int ret = 0;

    // Special environment to prefer .pyo, and don't write bytecode if .py are found
    // because the process will not have a write attribute on the device.
    putenv("PYTHONOPTIMIZE=2");
    putenv("PYTHONDONTWRITEBYTECODE=1");
    putenv("PYTHONNOUSERSITE=1");
    putenv("PYTHONPATH=.");
    putenv("PYTHONUNBUFFERED=1");
    putenv("LC_CTYPE=UTF-8");
    // putenv("PYTHONVERBOSE=1");
    // putenv("PYOBJUS_DEBUG=1");

    NSString * resourcePath = [[NSBundle bundleForClass:[Python class]] URLForResource:@"python3" withExtension:nil].path;
    NSString *python_home = [NSString stringWithFormat:@"PYTHONHOME=%@", resourcePath, nil];
    putenv((char *)[python_home UTF8String]);

    NSString *python_path = [NSString stringWithFormat:@"PYTHONPATH=%@:%@/lib/python3.8/:%@/lib/python3.8/site-packages:.", resourcePath, resourcePath, resourcePath, nil];
    putenv((char *)[python_path UTF8String]);

    NSString *tmp_path = [NSString stringWithFormat:@"TMP=%@/tmp", resourcePath, nil];
    putenv((char *)[tmp_path UTF8String]);

    NSLog(@"Initializing python");
    Py_Initialize();

    wchar_t** python_argv = PyMem_RawMalloc(sizeof(wchar_t *) *argc);
    for (int i = 0; i < argc; i++)
        python_argv[i] = Py_DecodeLocale(argv[i], NULL);
    PySys_SetArgv(argc, python_argv);

    // If other modules are using the thread, we need to initialize them before.
    PyEval_InitThreads();

    // Add an importer for builtin modules
    load_custom_builtin_importer();
    
    return self;
}

- (instancetype)init
{
    return [self initWithArgc:0 argv:nil];
}

- (void)dealloc
{
    Py_Finalize();
    NSLog(@"Leaving");
}

@end

void load_custom_builtin_importer() {
    static const char *custom_builtin_importer = \
        "import sys, imp, types\n" \
        "from os import environ\n" \
        "from os.path import exists, join\n" \
        "try:\n" \
        "    # python 3\n"
        "    import _imp\n" \
        "    EXTS = _imp.extension_suffixes()\n" \
        "    sys.modules['subprocess'] = types.ModuleType(name='subprocess')\n" \
        "    sys.modules['subprocess'].PIPE = None\n" \
        "    sys.modules['subprocess'].STDOUT = None\n" \
        "    sys.modules['subprocess'].DEVNULL = None\n" \
        "    sys.modules['subprocess'].CalledProcessError = Exception\n" \
        "    sys.modules['subprocess'].check_output = None\n" \
        "except ImportError:\n" \
        "    EXTS = ['.so']\n"
        "# Fake redirection to supress console output\n" \
        "if environ.get('KIVY_NO_CONSOLE', '0') == '1':\n" \
        "    class fakestd(object):\n" \
        "        def write(self, *args, **kw): pass\n" \
        "        def flush(self, *args, **kw): pass\n" \
        "    sys.stdout = fakestd()\n" \
        "    sys.stderr = fakestd()\n" \
        "# Custom builtin importer for precompiled modules\n" \
        "class CustomBuiltinImporter(object):\n" \
        "    def find_module(self, fullname, mpath=None):\n" \
        "        # print(f'find_module() fullname={fullname} mpath={mpath}')\n" \
        "        if '.' not in fullname:\n" \
        "            return\n" \
        "        if not mpath:\n" \
        "            return\n" \
        "        part = fullname.rsplit('.')[-1]\n" \
        "        for ext in EXTS:\n" \
        "           fn = join(list(mpath)[0], '{}{}'.format(part, ext))\n" \
        "           # print('find_module() {}'.format(fn))\n" \
        "           if exists(fn):\n" \
        "               return self\n" \
        "        return\n" \
        "    def load_module(self, fullname):\n" \
        "        f = fullname.replace('.', '_')\n" \
        "        mod = sys.modules.get(f)\n" \
        "        if mod is None:\n" \
        "            # print('LOAD DYNAMIC', f, sys.modules.keys())\n" \
        "            try:\n" \
        "                mod = imp.load_dynamic(f, f)\n" \
        "            except ImportError:\n" \
        "                # import traceback; traceback.print_exc();\n" \
        "                # print('LOAD DYNAMIC FALLBACK', fullname)\n" \
        "                mod = imp.load_dynamic(fullname, fullname)\n" \
        "            sys.modules[fullname] = mod\n" \
        "            return mod\n" \
        "        return mod\n" \
        "sys.meta_path.insert(0, CustomBuiltinImporter())";
    PyRun_SimpleString(custom_builtin_importer);
}
