//
//  FakeResponseData.swift
//  RecipleaseTests
//
//  Created by Christophe DURAND on 30/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    static let incorrectData = "error".data(using: .utf8)!
   
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    class AllTypeOfError: Error {}
    static let error = AllTypeOfError()
}

class FakeRecipeResponseData: FakeResponseData {
    static var searchRecipeCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "SearchRecipe", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var detailedRecipeCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "DetailedRecipe", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}
