//
//  SwiftBundle.swift
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

import Foundation
import LinkPython

private let importer = """
    import sys, imp, types
    from os import environ
    from os.path import exists, join

    try:
        # python 3
        import _imp

        EXTS = _imp.extension_suffixes()
        sys.modules['subprocess'] = types.ModuleType(name='subprocess')
        sys.modules['subprocess'].PIPE = None
        sys.modules['subprocess'].STDOUT = None
        sys.modules['subprocess'].DEVNULL = None
        sys.modules['subprocess'].CalledProcessError = Exception
        sys.modules['subprocess'].check_output = None
    except ImportError:
        EXTS = ['.so']

    # Fake redirection to supress console output
    if environ.get('KIVY_NO_CONSOLE', '0') == '1':
        class fakestd(object):
            def write(self, *args, **kw): pass
            def flush(self, *args, **kw): pass
        sys.stdout = fakestd()
        sys.stderr = fakestd()

    # Custom builtin importer for precompiled modules
    class CustomBuiltinImporter(object):
        def find_module(self, fullname, mpath=None):
            # print(f'find_module() fullname={fullname} mpath={mpath}')
            if '.' not in fullname:
                return
            if not mpath:
                return
            part = fullname.rsplit('.')[-1]
            for ext in EXTS:
                fn = join(list(mpath)[0], '{}{}'.format(part, ext))
            # print('find_module() {}'.format(fn))
            if exists(fn):
                return self
            return

        def load_module(self, fullname):
            f = fullname.replace('.', '_')
            mod = sys.modules.get(f)
            if mod is None:
                # print('LOAD DYNAMIC', f, sys.modules.keys())
                try:
                    mod = imp.load_dynamic(f, f)
                except ImportError:
                    # import traceback; traceback.print_exc();
                    # print('LOAD DYNAMIC FALLBACK', fullname)
                    mod = imp.load_dynamic(fullname, fullname)
                sys.modules[fullname] = mod
                return mod
            return mod

    sys.meta_path.insert(0, CustomBuiltinImporter())
    """

public func initialize() {
    // Special environment to prefer .pyo, and don't write bytecode if .py are found
    // because the process will not have a write attribute on the device.
    setenv("PYTHONOPTIMIZE", "2", 1)
    setenv("PYTHONDONTWRITEBYTECODE", "1", 1)
    setenv("PYTHONNOUSERSITE", "1", 1)
    setenv("PYTHONPATH", ".", 1)
    setenv("PYTHONUNBUFFERED", "1", 1)
    setenv("LC_CTYPE", "UTF-8", 1)
    // putenv("PYTHONVERBOSE=1");
    // putenv("PYOBJUS_DEBUG=1");

    let pythonHome = Bundle.module.bundleURL.path
    setenv("PYTHONHOME", pythonHome, 1)

    setenv("PYTHONPATH", "\(pythonHome)/lib/python3.8/:\(pythonHome)/lib/python3.8/site-packages", 1)

    setenv("TMP", NSTemporaryDirectory(), 1)

    _ = PythonInitialize(0, nil, importer)
}

public func finalize() {
    PythonFinalize()
}

public func runSimpleString(_ string: String) {
    PythonRunSimpleString(string)
}

public extension URL {
    func insertPythonPath() {
        runSimpleString("""
            import sys
            sys.path.insert(1, "\(path)")
            """)
    }
}
