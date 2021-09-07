//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 8/2/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var movies: [Movie]?
    lazy var manager: Manager = {
        return NetworkManager()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Facade.shared.retrieveData {[weak self] (result) in
            switch result {
            case .success(let movies):
                self?.movies = movies?.results
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
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        let movie = movies?[indexPath.row]
        cell.movieTitle.text = movie?.title ?? ""
        cell.movieRating.text = "Rating: \(movie?.popularity ?? 0)"
        if let url = URL(string: "https://image.tmdb.org/t/p/original" + "\(movie?.posterPath ?? "")" ) {
            url.getImageData { image in
                if let _ = image {
                    DispatchQueue.main.async {
                        cell.movieImage.contentMode = .scaleToFill
                        cell.movieImage.image = image!
                    }
                }
            }
        }
        
        return cell
    }
    
}


extension UIImageView {
    
}


extension URL {
    
    func getData(from url: URL, completion: @escaping(Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getImageData(completion: @escaping (UIImage?) -> ()) {
        self.getData(from: self) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }
    }
}

