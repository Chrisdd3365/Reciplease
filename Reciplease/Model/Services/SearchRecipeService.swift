//
//  SearchRecipeService.swift
//  Reciplease
//
//  Created by Christophe DURAND on 02/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation
import Alamofire

class SearchRecipeService {
    //MARK: - Property
    private var yummlySession: YummlySession
    
    init(yummlySession: YummlySession = YummlySession()) {
        self.yummlySession = yummlySession
    }
    
    //MARK: - Method
    //Method to get a recipe based on ingredients available in the fridge from Yummly API with a get request
    func getRecipe(ingredients: [String], completion: @escaping (Bool, [Matches]?) -> Void) {
        guard let url = URL(string: yummlySession.urlStringApi) else { return }
        let parameters = ["q": ingredients]
        yummlySession.request(url: url, method: .get, parameters: parameters, encoding: URLEncoding.default) { response in
            guard let data = response.data, response.error == nil else {
                completion(false, nil)
                return
            }
            guard let response = response.response, response.statusCode == 200 else {
                completion(false, nil)
                return
            }
            guard let searchRecipeResponseJSON = try? JSONDecoder().decode(SearchRecipe.self, from: data) else {
                completion(false, nil)
                return
            }
            completion(true, searchRecipeResponseJSON.matches)
        }
    }
}

    
    
    
    
    
    
    

