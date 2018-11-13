//
//  YummlyProtocol.swift
//  Reciplease
//
//  Created by Christophe DURAND on 10/11/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation
import Alamofire

protocol YummlyProtocol {
    
    //MARK: - Properties
    var urlStringApi: String { get }
    var urlStringDetailedBaseUrl: String { get }
    var urlStringDetailedIdAndKey: String { get }
    
    //MARK: - Methods
    func request (url: URL, method: HTTPMethod?, parameters: Parameters?, encoding: URLEncoding?, completionHandler: @escaping (DataResponse<Any>) -> Void)
}

extension YummlyProtocol {
    var urlStringApi: String {
        let baseURL = "http://api.yummly.com/v1/api/recipes?"
        let appIDURL = "_app_id="
        let appID = "c4496770"
        let appKeyURL = "&_app_key="
        let appKey = "e8a8dd20eb2e3745b0ea77aa2bdf2578"
        return baseURL + appIDURL + appID + appKeyURL + appKey
    }
    
    var urlStringDetailedBaseUrl: String {
        let baseURL = "http://api.yummly.com/v1/api/recipe/"
        return baseURL
    }
    
    var urlStringDetailedIdAndKey: String {
        let appIDURL = "_app_id="
        let appID = "c4496770"
        let appKeyURL = "&_app_key="
        let appKey = "e8a8dd20eb2e3745b0ea77aa2bdf2578"
        return appIDURL + appID + appKeyURL + appKey
    }
}
