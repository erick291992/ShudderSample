//
//  FlickrService.swift
//  Shudder
//
//  Created by Erick Manrique on 11/11/18.
//  Copyright © 2018 homeapps. All rights reserved.
//

import Foundation


class FlickrService {
    
    let networkService: NetworkService
    
    init() {
        networkService = NetworkService()
    }
    
    private enum FlickrParams:String {
        case apiKey
        case method
        case userId
        case format
        case noJsonCallback
        case perPage
        
        var key: String {
            
            switch self {
            case .apiKey:
                return "api_key"
            case .method:
                return "method"
            case .userId:
                return "user_id"
            case .format:
                return "format"
            case .noJsonCallback:
                return "nojsoncallback"
            case .perPage:
                return "per_page"
            }
        }
        
        var value: String {
            
            switch self {
            case .apiKey:
                return "231f052bf4f63790917558d15aa69ff7"
            case .method:
                return "flickr.people.getPhotos"
            case .userId:
                return "61302085@N05"
            case .format:
                return "json"
            case .noJsonCallback:
                return "1"
            case .perPage:
                return "64"
            }
        }
    }
    
    
    func getMovies(completion:@escaping(GenericCompletion<FlickrResult>)) {
        
        let url = Api.Flickr.Rest.url
        var parameters = [String:Any]()
        parameters[FlickrParams.apiKey.key] = FlickrParams.apiKey.value
        parameters[FlickrParams.method.key] = FlickrParams.method.value
        parameters[FlickrParams.userId.key] = FlickrParams.userId.value
        parameters[FlickrParams.format.key] = FlickrParams.format.value
        parameters[FlickrParams.perPage.key] = FlickrParams.perPage.value
        parameters[FlickrParams.noJsonCallback.key] = FlickrParams.noJsonCallback.value
        
        networkService.requestData(url: url, parameters: parameters, method: .get, completion: completion)
        
        
    }
    
}
