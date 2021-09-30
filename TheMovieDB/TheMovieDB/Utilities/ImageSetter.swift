//
//  ImageSetter.swift
//  TheMovieDB
//
//  Created by Juan Martin Rezk Elso on 20/9/21.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: String) {
        self.image = UIImage(named: "loading")
        Facade.shared.loadMovieImage(url) { (result) in
            switch result {
            case .success(let image):
                self.image = image
            case .failure(_):
                self.image = nil
            }
        }
    }
}
