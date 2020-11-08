import XCTest

import iperf_swiftTests

var tests = [XCTestCaseEntry]()
tests += iperf_swiftTests.allTests()
XCTMain(tests)
