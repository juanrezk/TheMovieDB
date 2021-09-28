//
//  NetworkTests.swift
//  TheMovieDBTests
//
//  Created by Juan Martin Rezk Elso on 23/9/21.
//

import XCTest
@testable import TheMovieDB

class NetworkTests: XCTestCase {
    func testRetrieveMovies() throws {
        let myExpectation = expectation(description: "task in background")
        let results = Facade.shared.retrieveData { (results) in
            myExpectation.fulfill()
            switch results {
            case .success(let movies):
                XCTAssertNotNil(results)
                XCTAssertGreaterThan(movies.results.count, 0)
            case .failure(let error):
                XCTAssertNotNil(error)
            }

        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testImageLoading() throws {
        let myExpectation = expectation(description: "task in background")
        let url = "/xBKGJQsAIeweesB79KC89FpBrVr.jpg"
        let results = Facade.shared.loadMovieImage(url) { (results) in
            myExpectation.fulfill()
            switch results {
            case .success(let movie):
                XCTAssertNotNil(results)
                XCTAssertNotNil(movie)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
}
