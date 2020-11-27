//
//  Resources.swift
//
//  Copyright (c) 2020 Changbeom Ahn
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
import Symbols

public let libURL = Bundle.module.url(forResource: "lib", withExtension: nil)

/// Initialize Python runtime
public func Init() {
    setenv("PYTHONOPTIMIZE", "1", 1)
    setenv("PYTHONDONTWRITEBYTECODE", "1", 1)
    setenv("PYTHONUNBUFFERED", "1", 1)

    SetPythonHome()

    setenv("PYTHONPATH",
           FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path,
           1)

    SetTMP()

    Py_Initialize()
}

/// Set Python Home to enable finding basic Python modules
public func SetPythonHome() {
    let pythonHome = Bundle.module.bundleURL.path
    let wHome = Py_DecodeLocale(pythonHome, nil)
    Py_SetPythonHome(wHome)
}

/// Set directory path for temporary files
public func SetTMP() {
    setenv("TMP", NSTemporaryDirectory(), 1)
}
