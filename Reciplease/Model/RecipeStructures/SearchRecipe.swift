//
//  SearchRecipe.swift
//  Reciplease
//
//  Created by Christophe DURAND on 08/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

struct SearchRecipe: Decodable {
    let matches: [Matches]
}

struct Matches: Decodable {
    let id: String
    let recipeName: String
    let ingredients: [String]
    let imageUrlsBySize: ImageUrlsBySize
    let totalTimeInSeconds: Int
    let rating: Int
 
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case rating
        case imageUrlsBySize
        case recipeName
        case ingredients
        case totalTimeInSeconds
    }
}

struct ImageUrlsBySize: Decodable {
    let image: String
    
    private enum CodingKeys: String, CodingKey {
        case image = "90"
    }
}
