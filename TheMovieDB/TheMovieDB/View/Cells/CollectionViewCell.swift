//
//  CollectionViewCell.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 17/9/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var movieTitle = UILabel()
    var movieImage = UIImageView()
    var movieRating = UILabel()
    var movieLang = UILabel()
    var postImageURL: String? {
        didSet {
            if let url = postImageURL {
                movieImage.loadImage(url: url)
            }
            else {
                movieImage.image = nil
            }
        }
    }
    
    private enum Constants {
        static let backgroundColor = UIColor(red: 15/255, green: 106/255, blue: 163/255, alpha: 1)
        static let margin = CGFloat(10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setUp() {
        contentView.backgroundColor = Constants.backgroundColor
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.addSubview(movieTitle)
        contentView.addSubview(movieImage)
        contentView.addSubview(movieRating)
        contentView.addSubview(movieLang)
        setTitleLayout()
        setImageLayout()
        setRatingLayout()
        setLangLayout()
    }
    
    func setTitleLayout() {
        movieTitle.textColor = .white
        movieTitle.numberOfLines = 0
        movieTitle.textAlignment = .center
        movieTitle.font = UIFont(name: "Copperplate", size: 22)
        setTitleConstraints()
    }
    
    func setImageLayout() {
        movieImage.layer.cornerRadius = 10
        movieImage.clipsToBounds = true
        movieImage.layer.borderWidth = 1
        movieImage.layer.borderColor = UIColor.white.cgColor
        setImageConstraints()
    }
    
    func setRatingLayout() {
        movieRating.textColor = .white
        movieRating.numberOfLines = 0
        movieRating.textAlignment = .center
        movieRating.font = UIFont(name: "Copperplate", size: 19)
        setRatingConstraints()
    }
    
    func setLangLayout() {
        movieLang.textColor = .white
        movieLang.numberOfLines = 0
        movieLang.textAlignment = .center
        movieLang.font = UIFont(name: "Copperplate", size: 19)
        setLangConstraints()
    }
    func setImageConstraints() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        movieImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 3/5).isActive = true
    }
    
    func setTitleConstraints() {
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: Constants.margin).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.margin).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.margin).isActive = true
    }
    
    func setRatingConstraints() {
        movieRating.translatesAutoresizingMaskIntoConstraints = false
        movieRating.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5).isActive = true
        movieRating.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.margin).isActive = true
        movieRating.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.margin).isActive = true
    }
    
    func setLangConstraints() {
        movieLang.translatesAutoresizingMaskIntoConstraints = false
        movieLang.topAnchor.constraint(equalTo: movieRating.bottomAnchor, constant: 5).isActive = true
        movieLang.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.margin).isActive = true
        movieLang.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.margin).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.text = ""
        movieImage.image = UIImage(named: "loading")
    }
}

extension CollectionViewCell: setUpCells {
    func setUp(movie: Movie) {
        movieTitle.text = movie.title
        movieRating.text = "Rating: \(movie.popularity ?? 0)"
        movieLang.text = "Language: \(movie.originalLanguage ?? "Unknown")"
        postImageURL = movie.backdropPath
    }
    
    
}
