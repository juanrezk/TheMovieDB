//
//  DetailViewController.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 17/9/21.
//

import UIKit

class DetailViewController: UIViewController {
    var movie: Movie
    let apiUrl = "https://image.tmdb.org/t/p/original"
    let movieImage = UIImageView()
    let movieTitle = UILabel()
    var postImageURL: String? {
        didSet {
            if let url = postImageURL {
                ImageSetter.setImage(url: url, movieImage: movieImage, postImageURL: postImageURL)
            }
            else {
                movieImage.image = nil
            }
        }
    }
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        view.backgroundColor = UIColor(red: 8/255, green: 46/255, blue: 120/255, alpha: 1)
        view.addSubview(movieImage)
        view.addSubview(movieTitle)
        setImageConstraints()
        setTitleConstraints()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        imageLayout()
        titleLayout()
    }
    
    func loadData() {
        movieTitle.text = movie.title
        postImageURL = "\(apiUrl)\(movie.backdropPath ?? "")"
    }
    
    func setImageConstraints() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10),
            movieImage.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
        movieImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func setTitleConstraints() {
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10),
            movieTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            movieTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
        
    }
    
    func imageLayout() {
        movieImage.layer.cornerRadius = 5
        movieImage.clipsToBounds = true
    }
    
    func titleLayout() {
        movieTitle.textColor = .white
        movieTitle.numberOfLines = 0
        movieTitle.textAlignment = .center
        movieTitle.font = UIFont(name: "Copperplate", size: 60)
    }
}
