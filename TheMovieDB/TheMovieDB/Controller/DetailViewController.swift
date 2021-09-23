//
//  DetailViewController.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 17/9/21.
//

import UIKit



class DetailViewController: UIViewController {
    var movie: Movie
    let movieImage = UIImageView()
    let movieTitle = UILabel()
    private enum Constants {
        static let backgroundColor = UIColor(red: 8/255, green: 46/255, blue: 120/255, alpha: 1)
        static let margin = CGFloat(10)
        static let cornerRadius = CGFloat(5)
    }
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        loadData()
        setImageLayout()
        setTitleLayout()
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(movieImage)
        view.addSubview(movieTitle)
        setImageConstraints()
        setTitleConstraints()
    }
    
    func loadData() {
        movieTitle.text = movie.title
        if let url = movie.backdropPath {
            movieImage.loadImage(url: url)
        } else {
            movieImage.image = nil
        }
    }
    
    func setImageConstraints() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: margins.topAnchor, constant: Constants.margin),
            movieImage.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
        movieImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
    }
    
    func setTitleConstraints() {
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: Constants.margin),
            movieTitle.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            movieTitle.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
        ])
        
    }
    
    func setImageLayout() {
        movieImage.layer.cornerRadius = Constants.cornerRadius
        movieImage.clipsToBounds = true
    }
    
    func setTitleLayout() {
        movieTitle.textColor = .white
        movieTitle.numberOfLines = 0
        movieTitle.textAlignment = .center
        movieTitle.font = UIFont(name: "Copperplate", size: 60)
    }
}
