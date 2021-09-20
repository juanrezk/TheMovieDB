//
//  ImageSetter.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 20/9/21.
//

import Foundation
import UIKit

struct ImageSetter {
    
static func setImage(url: String, movieImage: UIImageView, postImageURL: String?) {
    movieImage.image = UIImage(named: "loading")
    UIImage.loadImageUsingCacheWithUrlString(url) { image in
        // set the image only when we are still displaying the content for the image we finished downloading
        if url == postImageURL {
            movieImage.image = image
        }
    }
}
}
