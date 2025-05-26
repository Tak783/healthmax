//
//  XCTest+Result.swift
//  UserBiometricsFeature
//
//  Created by Tak Mazarura on 26/05/2025.
//

import XCTest

extension XCTest {
    func XCTAssertResultSuccess<T>(
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
}
