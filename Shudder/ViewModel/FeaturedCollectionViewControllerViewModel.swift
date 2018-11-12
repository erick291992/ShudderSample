//
//  FeaturedCollectionViewControllerViewModel.swift
//  Shudder
//
//  Created by Erick Manrique on 11/11/18.
//  Copyright © 2018 homeapps. All rights reserved.
//

import Foundation

class FeaturedCollectionViewControllerViewModel {
    
    let flickrService: FlickrService
    
    var featuredCollectionViewCellViewModels:Bindable = Bindable([FeaturedCollectionViewCellViewModel]())
    let featuresHeaderTitles: [String] = ["Newly Added", "Curator's Choice", "Only On Shudder", "The Master Of Suspense", "All Hail Argendo", "The End Nigh", "Monster Mash", "Binge This"]
    
    init() {
        flickrService = FlickrService()
    }
    
    func getMovies() {
        flickrService.getMovies { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let flickrResult, _):
                let photos = flickrResult.flickrData.photo
                
                let photosArray = photos.chunked(into: strongSelf.featuresHeaderTitles.count)
                
                strongSelf.featuredCollectionViewCellViewModels.value = photosArray.map {
                    let featuredCollectionViewCellViewModel = FeaturedCollectionViewCellViewModel(featuredPhotos: $0)
                    return featuredCollectionViewCellViewModel
                }
            case .failure(_):
                if appMode == .Debug {
                    log.debug("failed to get movie images")
                }
            }
        }
    }
    
}
