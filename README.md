# Python-iOS

This swift package enables you to use python modules in your iOS apps.

## Installation

```
.package(url: "https://github.com/kewlbear/Python-iOS.git", from: "0.0.1")
```

## Usage

```
import CPython
import Resources

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
```

## Credits

This package uses pre-built version of libraries downloaded from https://github.com/beeware/Python-Apple-support.

## License

MIT
