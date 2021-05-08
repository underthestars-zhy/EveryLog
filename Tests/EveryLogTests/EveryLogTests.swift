    import XCTest
    @testable import EveryLog

    final class EveryLogTests: XCTestCase {
        func testLog1() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
            let date = Date()
            XCTAssertEqual((try? EveryLog.stande.testLog(date: date, "test log"))!, "\(EveryLog.stande.date2String(date)) | test log")
        }
    }
