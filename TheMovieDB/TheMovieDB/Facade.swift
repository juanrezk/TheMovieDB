//
//  Facade.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 7/9/21.
//

import Foundation

final class Facade {
    // 1
    static let shared = Facade()
    // 2
    private init() {
        
    }
    
    private let networkManager = NetworkManager()
    
    func retrieveData(result: @escaping (Result<intermediaryJson?, Error>) -> Void) {
        networkManager.retrieveMovies(completion: result)
    }
    
}
