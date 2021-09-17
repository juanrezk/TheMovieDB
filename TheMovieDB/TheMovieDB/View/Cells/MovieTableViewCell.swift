//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 1/9/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    var movieTitle = UILabel()
    var movieImage = UIImageView()
    var postImageURL: String? {
        didSet {
            if let url = postImageURL {
                setImage(url: url)
            }
            else {
                movieImage.image = nil
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 20/255, green: 190/255, blue: 217/255, alpha: 1)
        addSubview(movieTitle)
        addSubview(movieImage)
        configureLabel()
        configureImageView()
        setTitleLabelConstraints()
        setImageConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.text = ""
        movieImage.image = UIImage(named: "loading")
    }
    
    func setImage(url:String) {
        movieImage.image = UIImage(named: "loading")
        UIImage.loadImageUsingCacheWithUrlString(url) { image in
            // set the image only when we are still displaying the content for the image we finished downloading
            if url == self.postImageURL {
                self.movieImage.image = image
            }
        }
    }
    

    func configureImageView() {
        movieImage.layer.cornerRadius = 10
        movieImage.clipsToBounds = true
    }
    
    func configureLabel() {
        movieTitle.numberOfLines = 0
        movieTitle.font = UIFont(name: "Copperplate", size: 24)
        movieTitle.textColor = .white
    }
    
    func setImageConstraints() {
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 95).isActive = true
        movieImage.widthAnchor.constraint(equalTo: movieImage.heightAnchor, multiplier: 16/8).isActive = true
    }
    
    func setTitleLabelConstraints() {
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 20).isActive = true
        movieTitle.heightAnchor.constraint(equalToConstant: 80).isActive = true
        movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true 
    }
    
}
