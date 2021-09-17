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
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(movieImage)
        view.addSubview(movieTitle)
        
        // Do any additional setup after loading the view.
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
