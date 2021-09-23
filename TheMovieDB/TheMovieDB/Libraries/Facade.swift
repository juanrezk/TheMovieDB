//
//  Facade.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 7/9/21.
//

import Foundation
import UIKit

final class Facade {
   
    //Singleton
    static let shared = Facade()
    private init() {
        
    }
    
    private let networkManager = NetworkManager()
    
    func retrieveData(result: @escaping (Result<intermediaryJson, Error>) -> Void) {
        networkManager.retrieveMovies(completion: result)
    }
    func loadMovieImage(_ urlString: String, result: @escaping (Result<UIImage, Error>) -> Void) {
        networkManager.loadImageUsingCacheWithUrlString(urlString, completion: result)
    }
    
}
