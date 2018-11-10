//
//  DetailedRecipeTests.swift
//  RecipleaseTests
//
//  Created by Christophe DURAND on 02/11/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import XCTest
import Alamofire
@testable import Reciplease

class DetailedRecipeTests: XCTestCase {
    
    func testGetDetailedRecipeShouldGetFailedCompletionIfError() {
        //Given
        let fakeResponse = FakeResponse(response: nil, data: nil, error: FakeResponseData.error)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let detailedRecipeService = DetailedRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        detailedRecipeService.getDetailedRecipe(id: "") { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailedRecipeShouldGetFailedCompletionIfNoData() {
        //Given
        let fakeResponse = FakeResponse(response: nil, data: nil, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let detailedRecipeService = DetailedRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        detailedRecipeService.getDetailedRecipe(id: "") { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailedRecipeShouldGetFailedCompletionIfIncorrectResponse() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseKO, data: FakeRecipeResponseData.detailedRecipeCorrectData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let detailedRecipeService = DetailedRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        detailedRecipeService.getDetailedRecipe(id: "") { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailedRecipeShouldGetFailedCompletionIfResponseCorrectAndNoData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: nil, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let detailedRecipeService = DetailedRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        detailedRecipeService.getDetailedRecipe(id: "") { success, recipe in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailedRecipeShouldGetFailedCompletionIfIncorrectData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let detailedRecipeService = DetailedRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        detailedRecipeService.getDetailedRecipe(id: "") { (success, recipe) in
            //Then
            XCTAssertFalse(success)
            XCTAssertNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDetailedRecipeShouldGetSuccessCompletionIfNoErrorAndCorrectData() {
        //Given
        let fakeResponse = FakeResponse(response: FakeResponseData.responseOK, data: FakeRecipeResponseData.detailedRecipeCorrectData, error: nil)
        let yummlySessionFake = YummlySessionFake(fakeResponse: fakeResponse)
        let detailedRecipeService = DetailedRecipeService(yummlySession: yummlySessionFake)
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change. ")
        detailedRecipeService.getDetailedRecipe(id: "") { (success, recipe) in
            //Then
            XCTAssertTrue(success)
            XCTAssertNotNil(recipe)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
