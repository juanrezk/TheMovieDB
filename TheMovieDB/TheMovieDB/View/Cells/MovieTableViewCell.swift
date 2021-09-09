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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.text = ""
        movieRating.text = ""
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
