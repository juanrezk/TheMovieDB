//
//  MovieTableViewCell.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 1/9/21.
//

import UIKit

class MovieTableViewCell: UITableViewCell, UITableViewDelegate {
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.text = ""
        movieRating.text = ""
        
    }
}
