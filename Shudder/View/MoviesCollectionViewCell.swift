//
//  MoviesCollectionViewCell.swift
//  Shudder
//
//  Created by Erick Manrique on 11/11/18.
//  Copyright © 2018 homeapps. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var movieImageView: CachedImageView!
    
    // MARK: - Variables
    var movie: Photo? {
        didSet {
            guard let movie = movie else {
                return
            }
            
            let imageUrl = "https://farm\(movie.farm).staticflickr.com/\(movie.server)/\(movie.id)_\(movie.secret).jpg"
            movieImageView.loadImage(urlString: imageUrl)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Setting up round corners
        movieImageView.layer.cornerRadius = 4
        movieImageView.layer.masksToBounds = true
        movieImageView.clipsToBounds = true
    }

}
