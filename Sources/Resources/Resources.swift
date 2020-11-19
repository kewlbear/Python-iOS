//
//  Resources.swift
//  
//
//  Created by 안창범 on 2020/11/11.
//

import Foundation
import Symbols

public let libURL = Bundle.module.url(forResource: "lib", withExtension: nil)

public func Init() {
    setenv("PYTHONOPTIMIZE", "1", 1)
    setenv("PYTHONDONTWRITEBYTECODE", "1", 1)
    setenv("PYTHONUNBUFFERED", "1", 1)

    guard let pythonHome = Resources.libURL?
            .deletingLastPathComponent()
            .path else { fatalError() }
    let wHome = Py_DecodeLocale(pythonHome, nil)
    Py_SetPythonHome(wHome)

    setenv("PYTHONPATH",
           FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].path,
           1)

    setenv("TMP", NSTemporaryDirectory(), 1)

    Py_Initialize()
}
