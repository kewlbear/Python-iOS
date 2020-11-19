import XCTest
@testable import Symbols

final class PythonTests: XCTestCase {
    func testExample() {
        let x = _Py_True
        PyNumber_Add(nil, nil)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
