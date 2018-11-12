//
//  Constants.swift
//  Shudder
//
//  Created by Erick Manrique on 11/10/18.
//  Copyright © 2018 homeapps. All rights reserved.
//

import Foundation
import UIKit

// set this to release when publishing app
let appMode = AppMode.Debug

enum AppMode {
    case Debug
    case Release
}

enum Api {
    enum Flickr: String {
        case Url = "https://api.flickr.com/services"
        case Rest = "/rest"
        var url: String {
            return Flickr.Url.rawValue + self.rawValue
        }
    }
}
