//
//  FakeResponse.swift
//  RecipleaseTests
//
//  Created by Christophe DURAND on 10/11/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

struct FakeResponse {
    var data: Data?
    var error: Error?
    var response: HTTPURLResponse?
}
