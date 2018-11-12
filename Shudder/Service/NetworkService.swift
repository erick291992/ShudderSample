//
//  NetworkService.swift
//  Shudder
//
//  Created by Erick Manrique on 11/10/18.
//  Copyright © 2018 homeapps. All rights reserved.
//

import Alamofire

enum EmptyResult<T:Any, U: Error> {
    case success(T)
    case failure(U?)
}

enum Result<T:Decodable, U, V: Error> {
    case success(object: T, value: U)
    case failure(V?)
}

enum FailureReason: Int, Error {
    case badRequest = 400
    case unAuthorized = 401
    case notFound = 404
    case internalErrorServer = 500
}

typealias EmptyRequestResult = EmptyResult<Any, FailureReason>
typealias EmptyRequestCompletion = (_ result: EmptyRequestResult) -> Void

typealias GenericResult<T:Decodable> = Result<T, Any, FailureReason>
typealias GenericCompletion<T:Decodable> = (_ result: GenericResult<T>) -> Void

class NetworkService {
    
    let alamofire:SessionManager
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 3;
        alamofire = Alamofire.SessionManager(configuration: configuration)
        
    }
    /**
     Easily make api request for and get back an object of any type
     
     - parameter url: The url that will be called
     - parameter parameters: Optional dictionary[String:Any] that will be sent over as q query string or json
     - parameter headers: Optional dictionary[string:string] that will be sent over as q query string or json
     - parameter method: Allows to send either post get requests
     - parameter completion: A generic completion that will allow return a result enum with success and failure
     */
    
    func requestData<T:Decodable>(url:String, parameters:[String:Any]? = nil, headers:[String:String]? = nil, method: Alamofire.HTTPMethod = .get, completion:@escaping GenericCompletion<T>) {
        
        var encoding:ParameterEncoding!
        switch method {
        case .get:
            encoding = URLEncoding.default
        default:
            encoding = JSONEncoding.default
        }
        
        alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { (response) in
            
            
            switch response.result {
            case .success:
                guard let jsonData = response.data, let jsonValue = response.result.value else {
                    completion(.failure(nil))
                    return
                }
                do {
                    let obj = try JSONDecoder().decode(T.self, from: jsonData)
                    completion(.success(object:obj, value: jsonValue))
                } catch let error {
                    if appMode == .Debug{
                        log.error(error)
                    }
                    completion(.failure(nil))
                }
            case .failure(_):
                if let statusCode = response.response?.statusCode,
                    let reason = FailureReason(rawValue: statusCode) {
                    if appMode == .Debug{
                        log.error("failed with statusCode:\(statusCode)")
                    }
                    completion(.failure(reason))
                }
            }
        }
        
    }
    
    /**
     Easily make api request for and get back a dictionary of the responce
     
     - parameter url: The url that will be called
     - parameter parameters: Optional dictionary[String:Any] that will be sent over as q query string or json
     - parameter headers: Optional dictionary[string:string] that will be sent over as q query string or json
     - parameter method: Allows to send either post get requests
     - parameter completion: A generic completion that will allow return a result enum with success and failure
     */
    
    func requestEmpty(url:String, parameters:[String:Any]? = nil, headers:[String:String]? = nil, method:Alamofire.HTTPMethod = .get, completion:@escaping EmptyRequestCompletion) {
        
        if let parameters = parameters {
            log.info("parameters\(parameters)")
        }

        var encoding:ParameterEncoding!
        switch method {
        case .get:
            encoding = URLEncoding.default
        default:
            encoding = JSONEncoding.default
        }
        
        alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers:headers).validate().responseJSON { (response) in
            
            switch response.result {
            case .success:
                guard let jsonValue = response.result.value else {
                    completion(.failure(nil))
                    return
                }
                
                completion(.success(jsonValue))
                
            case .failure(_):
                if let statusCode = response.response?.statusCode,
                    let reason = FailureReason(rawValue: statusCode) {
                    if appMode == .Debug{
                        log.error("failed with statusCode:\(statusCode)")
                    }
                    completion(.failure(reason))
                    return
                }
                if appMode == .Debug{
                    log.error("Request Empty failure")
                }
                completion(.failure(nil))
            }
            
        }
    }
    
}








