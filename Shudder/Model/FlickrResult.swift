//
//  FlickrResult.swift
//  Shudder
//
//  Created by Erick Manrique on 11/11/18.
//  Copyright © 2018 homeapps. All rights reserved.
//

import Foundation

struct FlickrResult: Codable {
    var flickrData: FlickrData
    
    // Mapping variables to keys that decodable will use to load into from json
    private enum CodingKeys : String, CodingKey {
        case flickrData = "photos"
    }
}

struct FlickrData: Codable {
    var pages: Int
    var perpage: Int
    var total: String
    var photo: [Photo]
    
}
