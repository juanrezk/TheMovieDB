//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 8/2/21.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoImage: UIImageView!
    var movies: [Movie] = []
    let apiUrl = "https://image.tmdb.org/t/p/w500"
    
    func getDataFromFacade() {
        Facade.shared.retrieveData { [weak self] (result) in
            switch result {
            case .success(let movies):
                self?.movies = movies.results
                DispatchQueue.main.async {
                    self?.tableView.isHidden = false
                    self?.tableView.reloadData()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.tableView.isHidden = true
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.image = UIImage(named: "themoviedb")
        getDataFromFacade()
    }
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        return loadCells(cell: cell, movie: movie)
    }
    
    func loadCells(cell: MovieTableViewCell, movie: Movie) -> UITableViewCell {
        cell.movieTitle.text = movie.title
        cell.movieRating.text = "Rating: \(movie.popularity ?? 0)"
        cell.postImageURL = "\(apiUrl)\(movie.backdropPath ?? "")"
        
        return cell
    }
    
    
}

//I am almost convinced that this piece of code should be put in network class
let imageCache = NSCache<NSString, AnyObject>()
extension UIImage {
    static func loadImageUsingCacheWithUrlString(_ urlString: String, completion: @escaping (UIImage) -> Void) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            completion(cachedImage)
        }
        
        //No cache, so create new one and set image
        guard let url = URL(string: urlString) else{
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    completion(downloadedImage)
                }
            })
            
        }).resume()
    }
}

