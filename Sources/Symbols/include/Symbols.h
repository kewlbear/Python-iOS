//
//  Symbols.h
//  
//
//  Created by 안창범 on 2020/11/18.
//

#ifndef Symbols_h
#define Symbols_h

#import <sys/types.h>

void *getSymbol(const char*);

void Py_Initialize();

wchar_t* Py_DecodeLocale(const char* arg, size_t *size);

void Py_SetPythonHome(const wchar_t *home);

#endif /* Symbols_h */
