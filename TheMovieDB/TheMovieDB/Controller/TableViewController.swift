//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 8/2/21.
//

import UIKit

class TableViewController: UIViewController {
    
    
    
    @IBOutlet weak var logoImage: UIImageView!
    var tableview: UITableView = {
        let table = UITableView()
        return table
    }()
    var collectionView: UICollectionView?
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
    var movies: [Movie] = []
    let apiUrl = "https://image.tmdb.org/t/p/w500"
    
    func getDataFromFacade() {
        Facade.shared.retrieveData { [weak self] (result) in
            switch result {
            case .success(let movies):
                self?.movies = movies.results
                DispatchQueue.main.async {
                    switch self?.deviceIdiom {
                    case .phone:
                        self?.tableview.isHidden = false
                        self?.tableview.reloadData()
                        
                    default:
                        self?.collectionView?.isHidden = false
                        self?.collectionView?.reloadData()
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    switch self?.deviceIdiom {
                    case .phone:
                        self?.tableview.isHidden = true
                    default:
                        self?.collectionView?.isHidden = true
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.image = UIImage(named: "themoviedb")
        switch deviceIdiom {
        case .phone:
            configureTableView()
        default:
            configureCollectionView()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
        tableview.backgroundColor = UIColor(red: 26/255, green: 178/255, blue: 201/255, alpha: 1)
        tableview.rowHeight = 150
    }
    
    func configureTableView() {
        getDataFromFacade()
        view.addSubview(tableview)
        tableview.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        tableview.dataSource = self
        tableview.delegate = self
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/3) - 4, height: (view.frame.size.width/3) - 4)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.backgroundColor =  UIColor(red: 26/255, green: 178/255, blue: 201/255, alpha: 1)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        getDataFromFacade()
    }
    
    func goToDV(indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let vc = DetailViewController(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell else {
            return UITableViewCell()
        }
        return loadTableCells(cell: cell, movie: movie)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDV(indexPath: indexPath)
    }
    
    func loadTableCells(cell: MovieTableViewCell, movie: Movie) -> UITableViewCell {
        cell.movieTitle.text = movie.title
        cell.postImageURL = "\(apiUrl)\(movie.backdropPath ?? "")"
        return cell
    }
    
    
}

extension TableViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = movies[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        return loadCollectionCells(cell: cell, movie: movie)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToDV(indexPath: indexPath)
    }
    
    func loadCollectionCells(cell: CollectionViewCell, movie: Movie) -> UICollectionViewCell {
        cell.movieTitle.text = movie.title
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

