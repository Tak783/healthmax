//
//  XCTest+Result.swift
//  UserBiometricsFeature
//
//  TODO: Add to new CoreXCTest, CoreXCTesting or CoreTesting package
//
//  Created on 26/05/2025.
//

import XCTest

extension XCTest {
    func XCTAssertResultVoidSuccess<T>(
        _ result: Result<T, any Error>,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ message: @autoclosure () -> String = "Expected .success but got .failure"
    ) {
        switch result {
        case .success:
            XCTAssertTrue(true, file: file, line: line)
        case .failure(let error):
            XCTFail("\(message()) — Error: \(error)", file: file, line: line)
        }
    }
    
    func XCTAssertResultSuccess<T: Equatable>(
        _ result: Result<T, any Error>,
        equals expected: T,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        switch result {
        case .success(let value):
            XCTAssertEqual(value, expected, file: file, line: line)
        case .failure(let error):
            XCTFail("Expected success with value \(expected), got failure: \(error)", file: file, line: line)
        }
    }
}
