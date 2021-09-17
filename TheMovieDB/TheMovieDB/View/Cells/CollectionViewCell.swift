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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        contentView.addSubview(movieTitle)
        contentView.addSubview(movieImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieTitle.textColor = .white
        movieTitle.numberOfLines = 0
        movieTitle.textAlignment = .center
        movieTitle.font = UIFont(name: "Copperplate", size: 20)
        movieTitle.frame = CGRect(x: 5, y: contentView.frame.size.height - 50, width: contentView.frame.size.height - 10, height: 50)
        movieImage.layer.cornerRadius = 10
        movieImage.clipsToBounds = true
        movieImage.frame = CGRect(x: 5, y: contentView.frame.size.height - 240, width: contentView.frame.size.height - 10, height: 190)
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

}
