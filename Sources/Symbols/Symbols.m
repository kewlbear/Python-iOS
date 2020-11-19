//
//  Symbols.m
//  
//
//  Created by 안창범 on 2020/11/18.
//

#import "Symbols.h"
#import <Foundation/Foundation.h>
#import <Python.h>

#define SYMBOL(symbol) @#symbol: [NSValue valueWithPointer: symbol]

static NSDictionary *symbols;

void *getSymbol(const char *name) {
    if (!symbols) {
        symbols = @{
            SYMBOL(Py_Initialize),
            SYMBOL(PyEval_GetBuiltins),
            SYMBOL(Py_IncRef),
            SYMBOL(PyRun_SimpleString),
            SYMBOL(PyUnicode_DecodeUTF8),
            SYMBOL(Py_DecRef),
            SYMBOL(PyBool_FromLong),
            SYMBOL(PyObject_GetAttrString),
            SYMBOL(PyErr_Occurred),
            SYMBOL(PyTuple_New),
            SYMBOL(PyObject_CallObject),
            SYMBOL(PyLong_AsLong),
            SYMBOL(PyDict_New),
            SYMBOL(PyDict_SetItem),
            SYMBOL(PyImport_ImportModule),
            SYMBOL(PyObject_GetIter),
            SYMBOL(PyIter_Next),
            SYMBOL(PyObject_RichCompareBool),
            SYMBOL(PyUnicode_AsUTF8),
            SYMBOL(PyLong_FromLong),
            SYMBOL(PyTuple_SetItem),
            SYMBOL(PyObject_Call),
            SYMBOL(PyObject_GetItem),
            SYMBOL(PyDict_Next),
            SYMBOL(PyErr_Fetch),
        };
    }

    void *symbol = [(NSValue *) symbols[[NSString stringWithUTF8String:name]] pointerValue];
    NSLog(@"%s: %s", __func__, name);
    assert(symbol);
    return symbol;
}
