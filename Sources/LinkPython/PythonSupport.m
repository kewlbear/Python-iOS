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

#import "PythonSupport.h"

void Py_Initialize(void);
void *PyMem_RawMalloc(size_t);
wchar_t *Py_DecodeLocale(const char *, size_t *);
void PySys_SetArgv(int, wchar_t **);
void PyEval_InitThreads(void);
int PyRun_SimpleString(const char *);
void Py_Finalize(void);

void Py_IncRef(void *);
void Py_DecRef(void *);

int PythonInitialize(int argc, const char **argv, const char *custom_builtin_importer)
{
    int ret = 0;

    Py_Initialize();

    wchar_t** python_argv = PyMem_RawMalloc(sizeof(wchar_t *) *argc);
    for (int i = 0; i < argc; i++)
        python_argv[i] = Py_DecodeLocale(argv[i], NULL);
    PySys_SetArgv(argc, python_argv);

    // If other modules are using the thread, we need to initialize them before.
    PyEval_InitThreads();

    // Add an importer for builtin modules
    PyRun_SimpleString(custom_builtin_importer);

    return ret;
}

void PythonFinalize()
{
    Py_Finalize();
}

void PythonRunSimpleString(const char *string)
{
    PyRun_SimpleString(string);
}

ForceLink(Python, Py_IncRef(nil); Py_DecRef(nil))
