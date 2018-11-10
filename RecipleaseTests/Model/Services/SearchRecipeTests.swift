//
//  SearchRecipeTests.swift
//  RecipleaseTests
//
//  Created by Christophe DURAND on 02/11/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import XCTest
import Alamofire
@testable import Reciplease

class SearchRecipeTests: XCTestCase {
    
    func testGetRecipeShouldGetFailedCompletionIfError() {
        //Given
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.error)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let searchRecipeService = SearchRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        searchRecipeService.getRecipe(ingredients: [""]) { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldGetFailedCompletionIfNilData() {
        //Given
        let fakeResponse = FakeResponse(response: nil, data: nil, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let searchRecipeService = SearchRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        searchRecipeService.getRecipe(ingredients: [""]) { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldGetFailedCompletionIfIncorrectResponse() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeRecipeResponseData.searchRecipeCorrectData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let searchRecipeService = SearchRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        searchRecipeService.getRecipe(ingredients: [""]) { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldGetFailedCompletionIfResponseCorrectAndNoData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let searchRecipeService = SearchRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        searchRecipeService.getRecipe(ingredients: [""]) { success, recipe in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldGetFailedCompletionIfIncorrectData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let searchRecipeService = SearchRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        searchRecipeService.getRecipe(ingredients: [""]) { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipeShouldGetSuccessCompletionIfNoErrorAndCorrectData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeRecipeResponseData.searchRecipeCorrectData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let searchRecipeService = SearchRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        searchRecipeService.getRecipe(ingredients: [""]) { (success, recipe) in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
