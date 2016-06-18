import XCTest
@testable import ZewoSrv

class ZewoSrvTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(ZewoSrv().text, "Hello, World!")
    }


    static var allTests : [(String, (ZewoSrvTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
