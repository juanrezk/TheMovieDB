//
//  NetworkManager.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 1/9/21.
//

import Foundation

protocol Manager {
    func retrieveMovies(completion: @escaping (Result<intermediaryJson, Error>) -> Void)
}

enum NetworkError: Error {
    case urlError
    case serverError
    case parsingError
}

class NetworkManager: Manager {
    func retrieveMovies(completion: @escaping (Result<intermediaryJson, Error>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=d0b82d9ad21c5aa4e12d4cf1acfb1155&language=en-US&page=1") else {
            completion(.failure(NetworkError.urlError))
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard error == nil, let myResponse = response as? HTTPURLResponse, myResponse.statusCode == 200, let myData = data else {
                completion(.failure(NetworkError.serverError))
                return
            }
            
            do {
                let movies = try JSONDecoder().decode(intermediaryJson.self, from: myData)
                completion(.success(movies))
            }
            catch let error {
                completion(.failure(NetworkError.parsingError))
                print(error)
            }
            
        }
        dataTask.resume()
    }
}
