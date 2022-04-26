//
//  WebRoutesTests.swift
//  NewsTests
//
//  Created by Ian Grünig on 26.04.22.
//

import XCTest

@testable import News

class WebRoutesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTagURL_FirstTag_ReturnsURLForFirstTag() throws {
        // given
        let tag = WebRoutes.tags[0]
        
        // when
        let url = WebRoutes.urlForTag(tag)
        
        // then
        XCTAssertEqual(url!.absoluteString, "https://mb21.github.io/blog/tags/\(tag)")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
