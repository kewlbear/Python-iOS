import XCTest
@testable import PythonKit

final class PythonTests: XCTestCase {
    func testExample() {
        Python.vers
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
