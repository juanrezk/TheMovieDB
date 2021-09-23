//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Jaime Laino on 8/2/21.
//

import UIKit

class MovieListViewController: UIViewController {
    private enum Constants {
        static let backgroundColor = UIColor(red: 8/255, green: 46/255, blue: 120/255, alpha: 1)
        static let margin = CGFloat(10)
        static let cornerRadius = CGFloat(5)
        static let rowHeight = CGFloat(150)
    }
    @IBOutlet weak var logoImage: UIImageView!
    lazy var tableview: UITableView = {
        let table = UITableView()
        return table
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.backgroundColor = Constants.backgroundColor
        return collectionView
    }()
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
    var movies: [Movie] = []
    
    func getDataFromFacade() {
        Facade.shared.retrieveData { [weak self] (result) in
            switch result {
            case .success(let movies):
                self?.movies = movies.results
                DispatchQueue.main.async {
                    switch self?.deviceIdiom {
                    case .phone:
                        self?.showTable()
                    default:
                        self?.showCollection()
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.tableview.isHidden = true
                    self?.collectionView.isHidden = true
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
    
    func showTable() {
        tableview.isHidden = false
        tableview.reloadData()
    }
    
    func showCollection() {
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
    func configureTableView() {
        view.addSubview(tableview)
        tableview.layer.cornerRadius = Constants.cornerRadius
        tableview.clipsToBounds = true
        tableview.backgroundColor = Constants.backgroundColor
        tableview.rowHeight = Constants.rowHeight
        setTableViewConstraints()
        tableview.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        tableview.dataSource = self
        tableview.delegate = self
        getDataFromFacade()
    }
    
    func setTableViewConstraints() {
        tableview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: Constants.margin),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableview.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/3) - 4, height: (view.frame.size.width/3) - 4)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
        setCollectionViewConstraints()
        getDataFromFacade()
    }
    
    func setCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: Constants.margin),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2/3),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    
    func goToDetailView(indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let detailViewController = DetailViewController(movie: movie)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
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
        goToDetailView(indexPath: indexPath)
    }
    
    func loadTableCells(cell: MovieTableViewCell, movie: Movie) -> UITableViewCell {
        cell.movieTitle.text = movie.title
        cell.postImageURL = movie.backdropPath ?? ""
        return cell
    }
    
    
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        goToDetailView(indexPath: indexPath)
    }
    
    func loadCollectionCells(cell: CollectionViewCell, movie: Movie) -> UICollectionViewCell {
        cell.movieTitle.text = movie.title
        cell.postImageURL = movie.backdropPath ?? ""
        return cell
    }
}

