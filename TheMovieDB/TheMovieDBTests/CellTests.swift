//
//  CellTests.swift
//  TheMovieDBTests
//
//  Created by Juan Martin Rezk Elso on 24/9/21.
//

import XCTest
@testable import TheMovieDB

class CellTests: XCTestCase {
    func test_MovieCell_setupDataCorrectly() throws {
        let fakeMovie = Movie(posterPath: "", adult: true, overview: "", releaseDate: "", genreIds: [], id: 1, originalTitle: "", originalLanguage: "KO", title: "HOPES", backdropPath: "", popularity: 8.216, voteCount: 0, video: true, voteAverage: 0)
        let cell =  MovieTableViewCell()
        cell.setUp(movie: fakeMovie)
        XCTAssertEqual(cell.movieTitle.text, fakeMovie.title)
        XCTAssertEqual(cell.movieRating.text, "Rating: \(fakeMovie.popularity ?? 0)")
        XCTAssertEqual(cell.movieLang.text, "Language: \(fakeMovie.originalLanguage ?? "")")
    }
}
