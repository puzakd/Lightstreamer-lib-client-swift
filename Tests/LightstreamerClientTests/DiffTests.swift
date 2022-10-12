import Foundation
import XCTest
@testable import LightstreamerClient

final class DiffTests: XCTestCase {
    func testDecode() {
        XCTAssertEqual("", try! DiffDecoder.apply("", ""));
        XCTAssertEqual("foo", try! DiffDecoder.apply("foo", "d")); // copy(3)
        XCTAssertEqual("foo", try! DiffDecoder.apply("foobar", "d")); // copy(3)
        XCTAssertEqual("fzap", try! DiffDecoder.apply("foobar", "bdzap")); // copy(1)add(3,zap)
        XCTAssertEqual("fzapbar", try! DiffDecoder.apply("foobar", "bdzapcd")); // copy(1)add(3,zap)del(2)copy(3)
        XCTAssertEqual("zapfoo", try! DiffDecoder.apply("foobar", "adzapad")); // copy(0)add(3,zap)del(0)copy(3)
        XCTAssertEqual("foo", try! DiffDecoder.apply("foobar", "aaad")); // copy(0)add(0)del(0)copy(3)
        XCTAssertEqual("1", try! DiffDecoder.apply("abcdefghijklmnopqrstuvwxyz1", "aaBab")); // copy(0)add(0)del(26)copy(1)
      }
}
