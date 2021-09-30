//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 1/9/21.
//

import UIKit

protocol setUpCells {
    func setUp(movie: Movie) -> Void
}


class MovieTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let backgroundColor = UIColor(red: 8/255, green: 46/255, blue: 120/255, alpha: 1)
        static let cornerRadius = CGFloat(10)
        static let tableCellConstant = CGFloat(10)
    }
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.text = ""
        movieImage.image = UIImage(named: "loading")
    }
    
    func setUp() {
        backgroundColor = Constants.backgroundColor
        addSubview(movieTitle)
        addSubview(movieImage)
        addSubview(movieRating)
        addSubview(movieLang)
        setImageLayout()
        setTitleLayout()
        setRatingLayout()
        setLangLayout()
    }
    
    func setImageLayout() {
        movieImage.layer.cornerRadius = Constants.cornerRadius
        movieImage.clipsToBounds = true
        movieImage.layer.borderWidth = 1/2
        movieImage.layer.borderColor = UIColor.white.cgColor
        setImageConstraints()
    }
    
    func setTitleLayout() {
        movieTitle.numberOfLines = 0
        movieTitle.font = UIFont(name: "Copperplate", size: 21)
        movieTitle.textColor = .white
        setTitleConstraints()
    }
    
    func setRatingLayout() {
        movieRating.font = UIFont(name: "Copperplate", size: 15)
        movieRating.textColor = .white
        setRatingConstraints()
    }
    
    func setLangLayout() {
        movieLang.font = UIFont(name: "Copperplate", size: 15)
        movieLang.textColor = .white
        setLangConstraints()
    }
    
    func setImageConstraints() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.topAnchor.constraint(equalTo: topAnchor, constant: Constants.tableCellConstant).isActive = true
        movieImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.tableCellConstant).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.tableCellConstant).isActive = true
        movieImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/2).isActive = true
    }
    
    func setTitleConstraints() {
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: Constants.tableCellConstant).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.tableCellConstant).isActive = true
    }
    
    func setRatingConstraints() {
        movieRating.translatesAutoresizingMaskIntoConstraints = false
        movieRating.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: Constants.tableCellConstant).isActive = true
        movieRating.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: Constants.tableCellConstant).isActive = true
        movieRating.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.tableCellConstant).isActive = true
    }
    
    func setLangConstraints() {
        movieLang.translatesAutoresizingMaskIntoConstraints = false
        movieLang.topAnchor.constraint(equalTo: movieRating.bottomAnchor, constant: Constants.tableCellConstant).isActive = true
        movieLang.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: Constants.tableCellConstant).isActive = true
        movieLang.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.tableCellConstant).isActive = true
    }
}

extension MovieTableViewCell: setUpCells {
    func setUp(movie: Movie) {
        movieTitle.text = movie.title
        movieRating.text = "Rating: \(movie.popularity ?? 0)"
        movieLang.text = "Language: \(movie.originalLanguage ?? "Unknown")"
        postImageURL = movie.backdropPath
    }
}
