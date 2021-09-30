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
    let movieOverview = UILabel()
    private enum Constants {
        static let backgroundColor = UIColor(red: 8/255, green: 46/255, blue: 120/255, alpha: 1)
        static let margin = CGFloat(10)
        static let cornerRadius = CGFloat(5)
    }
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
    
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
        view.addSubview(movieImage)
        view.addSubview(movieTitle)
        view.addSubview(movieOverview)
        setImageLayout()
        setTitleLayout()
        setOverviewLayout()
        view.backgroundColor = Constants.backgroundColor
    }
    
    func loadData() {
        movieTitle.text = movie.title
        movieOverview.text = movie.overview
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
    
    func setOverviewConstraints() {
        movieOverview.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            movieOverview.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: Constants.margin),
            movieOverview.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            movieOverview.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
    }
    
    func setOverviewLayout() {
        movieOverview.textColor = .white
        movieOverview.numberOfLines = 0
        movieOverview.textAlignment = .center
        movieOverview.adjustsFontSizeToFitWidth = true
        if deviceIdiom == .pad {
            movieOverview.font = UIFont(name: "Copperplate", size: 25)
        } else {
            movieOverview.font = UIFont(name: "Copperplate", size: 15)
        }
        setOverviewConstraints()
    }
    
    func setImageLayout() {
        movieImage.layer.cornerRadius = Constants.cornerRadius
        movieImage.clipsToBounds = true
        movieImage.layer.borderWidth = 2
        movieImage.layer.borderColor = UIColor.white.cgColor
        setImageConstraints()
    }
    
    func setTitleLayout() {
        movieTitle.textColor = .white
        movieTitle.numberOfLines = 0
        movieTitle.textAlignment = .center
        if deviceIdiom == .pad {
        movieTitle.font = UIFont(name: "Copperplate", size: 60)
        } else {
            movieTitle.font = UIFont(name: "Copperplate", size: 35)
        }
        setTitleConstraints()
    }
}
