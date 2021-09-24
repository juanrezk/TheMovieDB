//
//  CellTests.swift
//  TheMovieDBTests
//
//  Created by Juan Martin Rezk Elso on 24/9/21.
//

import XCTest
@testable import TheMovieDB

class CellTests: XCTestCase {
    func validateTitleLabel() throws {
        let indexPath = IndexPath()
        let movieTitle = "DILWALE DULHANIA LE JAYENGE"
        guard let cell = MovieListViewController().tableview.cellForRow(at: indexPath) as? MovieTableViewCell else {
            return
        }
        if(indexPath.row == 0){
            XCTAssertTrue(cell.movieTitle.text == movieTitle)
        }
    }
}
