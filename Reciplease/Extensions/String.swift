//
//  String.swift
//  Reciplease
//
//  Created by Christophe DURAND on 12/11/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation

extension String {
    func truncated(after count: Int) -> String {
        let truncateAfter = index(startIndex, offsetBy: count)
        guard endIndex > truncateAfter else { return self }
        return String(self[startIndex..<truncateAfter]) + "…"
    }
}
