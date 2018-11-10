//
//  YummlySession.swift
//  Reciplease
//
//  Created by Christophe DURAND on 10/11/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation
import Alamofire

class YummlySession: YummlyProtocol {
    func request(url: URL, method: HTTPMethod?, parameters: Parameters?, encoding: URLEncoding?, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            completionHandler(response)
        }
    }
}

