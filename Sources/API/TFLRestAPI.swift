//
//  TFLRestAPI.swift
//  Brunel
//
//  Created by Aaron McTavish on 18/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation

import Moya
import SwiftyJSON


enum RestAPIError: ErrorType {
    case GenericError(localizedDescription: String)
    case InvalidJSON(localizedDescription: String)
    case UnknownError
}


/**
 *  Interface between the app and TfL's REST API.
 */
struct TFLRestAPI {
    
    /// Shared instance for interacting with the API.
    static let sharedInstance = TFLRestAPI()
    
    /// Provider for the *Line* endpoints of the API.
    let lineProvider: MoyaProvider<TFLLineAPI>
    /// Provider for the *StopPoint* endpoints of the API.
    let stopPointProvider: MoyaProvider<TFLStopPointAPI>
    
    /**
     Initializes a new `TFLRestAPI`.
     */
    init() {
        guard let configFilePath = NSBundle.mainBundle().pathForResource("tflconfig", ofType: "plist"),
            configDictionary = NSDictionary(contentsOfFile: configFilePath) as? [String : AnyObject],
            appID = configDictionary["AppID"] as? String,
            appKey = configDictionary["AppKey"] as? String else {
                fatalError("Cannot find `tflconfig.plist` file.")
        }
        
        lineProvider = MoyaProvider<TFLLineAPI>(endpointClosure: TFLRestAPI.TFLEndpointClosure(appID, appKey: appKey))
        stopPointProvider = MoyaProvider<TFLStopPointAPI>(endpointClosure: TFLRestAPI.TFLEndpointClosure(appID, appKey: appKey))
    }
    
    /**
     Creates an endpoint closure to sign requests with the app's API keys.
     
     - parameter appID:  Identifier of the app.
     - parameter appKey: Key for the app.
     
     - returns: An endpoint closure for use with the TfL API.
     */
    static func TFLEndpointClosure<T: TargetType>(appID: String, appKey: String) -> (T -> Endpoint<T>) {
        return { (target: T) -> Endpoint<T> in
            var newParameters = [String : AnyObject]()
            
            newParameters["app_id"] = appID
            newParameters["app_key"] = appKey
            
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
    internal func tfl<T: TargetType>(provider: MoyaProvider<T>, target: T, completion: (JSON?, RestAPIError?) -> Void) {
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


/**
 Convenience function to create a URL string from an endpoint.
 
 - parameter route: Endpoint for which to generate a URL.
 
 - returns: URL string for endpoint.
 */
func url(route: TargetType) -> String {
    return route.baseURL.URLByAppendingPathComponent(route.path)!.absoluteString!
}
