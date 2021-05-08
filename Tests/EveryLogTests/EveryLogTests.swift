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
        
        func testLog2() {
            try! EveryLog.stande.addLog("Test Log")
            let logs = EveryLog.stande.getLog()
            XCTAssertEqual(logs[0].content, "Test Log")
        }
        
        func testLog3() {
            try! EveryLog.stande.addLog(type: .info, "Test Info Log")
            let logs = EveryLog.stande.getLog()
            XCTAssertEqual(logs[1].content, "Test Info Log")
            XCTAssertEqual(logs[1].type.rawValue, "info")
        }
    }
