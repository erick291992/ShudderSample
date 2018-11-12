//
//  FeaturedCollectionViewCellViewModel.swift
//  Shudder
//
//  Created by Erick Manrique on 11/11/18.
//  Copyright © 2018 homeapps. All rights reserved.
//

import Foundation


class FeaturedCollectionViewCellViewModel {
    var featuredPhotos:[Photo]
    
    init(featuredPhotos:[Photo]) {
        self.featuredPhotos = featuredPhotos
    }
}
