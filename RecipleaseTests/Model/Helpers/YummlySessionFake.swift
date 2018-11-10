//
//  YummlySessionFake.swift
//  RecipleaseTests
//
//  Created by Christophe DURAND on 10/11/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation
import Alamofire
@testable import Reciplease

class YummlySessionFake: YummlySession {
    
    private let fakeResponse: FakeResponse
    
    init(fakeResponse: FakeResponse) {
        self.fakeResponse = fakeResponse
        super.init()
    }
    
    override func request(url: URL, method: HTTPMethod?, parameters: Parameters?, encoding: URLEncoding?, completionHandler: @escaping (DataResponse<Any>) -> Void) {
        let httpResponse = fakeResponse.response
        let data = fakeResponse.data
        let error = fakeResponse.error
        
        let result = Request.serializeResponseJSON(options: .allowFragments, response: httpResponse, data: data, error: error)
        let urlRequest = URLRequest(url: URL(string: urlStringApi)!)
        completionHandler(DataResponse(request: urlRequest, response: httpResponse, data: data, result: result))
    }
}
