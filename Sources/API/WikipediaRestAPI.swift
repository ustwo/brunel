//
//  WikipediaRestAPI.swift
//  Brunel
//
//  Created by Aaron McTavish on 01/02/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation

import Moya
import SwiftyJSON


/**
 *  Interface between the app and Wikipedia's REST API.
 */
struct WikipediaRestAPI {
    
    /// Shared instance for interacting with the API.
    static let sharedInstance = WikipediaRestAPI()
    
    /// Provider for the endpoints of the API.
    let provider: MoyaProvider<WikipediaAPI>
    
    /**
     Initializes a new `WikipediaRestAPI`.
     */
    init() {
        provider = MoyaProvider<WikipediaAPI>(endpointClosure: WikipediaRestAPI.WikipediaEndpointClosure())
    }
    
    /**
     Creates an endpoint closure to add common parameters to all endpoints.
     
     - returns: An endpoint closure for use with the Wikipedia API.
     */
    static func WikipediaEndpointClosure<T: TargetType>() -> (T -> Endpoint<T>) {
        return { (target: T) -> Endpoint<T> in
            var newParameters = [String : AnyObject]()
            
            newParameters["format"] = "json"
            
            if let myParameters = target.parameters {
                for (key, value) in myParameters {
                    newParameters[key] = value
                }
            }
            
            let endpoint: Endpoint<T> = Endpoint<T>(URL: url(target), sampleResponseClosure: {.NetworkResponse(200, target.sampleData)}, method: target.method, parameters: newParameters, parameterEncoding: .URL, httpHeaderFields: nil)
            
            return endpoint
        }
    }
    
    /**
     Requests data from API endpoint and maps the response to a JSON object.
     
     - parameter provider:   Provider to use for for the endpoint.
     - parameter target:     Endpoint from which to request data.
     - parameter completion: Completion handler that returns either a valid JSON object or an error based on the response.
     */
    internal func wikipedia<T: TargetType>(provider: MoyaProvider<T>, target: T, completion: (JSON?, RestAPIError?) -> Void) {
        provider.request(target, completion: { result in
            switch result {
            case let .Success(response):
                do {
                    let jsonObj = try response.mapJSON()
                    let resultJSON = JSON(jsonObj)
                    
                    completion(resultJSON, nil)
                } catch let error as NSError {
                    completion(nil, .GenericError(localizedDescription: error.localizedDescription))
                    return
                }
            case let .Failure(error):
                completion(nil, .GenericError(localizedDescription: error.description))
                return
            }
        })
    }
    
}
