//
//  NetworkManager.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 1/9/21.
//

import Foundation
import UIKit

protocol Manager {
    func retrieveMovies(completion: @escaping (Result<intermediaryJson, Error>) -> Void)
    func loadImageUsingCacheWithUrlString(_ urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}

enum NetworkError: Error {
    case urlError
    case serverError
    case parsingError
    case dataError
}

class NetworkManager: Manager {
    let imageCache = NSCache<NSString, AnyObject>()
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
    func loadImageUsingCacheWithUrlString(_ urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let apiUrl = "https://image.tmdb.org/t/p/w500"
        if let cachedImage = imageCache.object(forKey: "\(apiUrl)\(urlString)" as NSString) as? UIImage {
            completion(.success(cachedImage))
        }
        //No cache, so create new one and set image
        guard let url = URL(string: "\(apiUrl)\(urlString)") else {
            completion(.failure(NetworkError.urlError))
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                completion(.failure(NetworkError.serverError))
                return
            }
            
            DispatchQueue.main.async(execute: {
                guard let data = data, let downloadedImage = UIImage(data: data) else {
                    completion(.failure(NetworkError.dataError))
                    return
                }
                    self.imageCache.setObject(downloadedImage, forKey: "\(apiUrl)\(urlString)" as NSString)
                    completion(.success(downloadedImage))
            })
            
        }).resume()
    }
}
