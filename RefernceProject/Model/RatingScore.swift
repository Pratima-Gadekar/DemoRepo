//
//  RatingScore.swift
//  FinalProject
//
//  Created by Arun Patwardhan on 08/08/18.
//  Copyright © 2018 Amaranthine. All rights reserved.
//

import Foundation

/**
 Possible scores that can be given.
 
 *values*
 
 `Excellent`
 
 Indicates a very good score
 
 `Good`
 
 Indicates a good score
 
 `Average`
 
 Indicates an average score
 
 `Acceptable`
 
 Indicates the least Acceptable score
 
 `Poor`
 
 Indicates a very bad score
 
 *functions*
 
 `func toInt() -> Int16`
 
 Used to convert and get the Int16 value
 
 `static func generate(withNumber input : Int16) -> Rating`
 
 Used to generate an enum value from Int 16
 
 - Author: Arun Patwardhan
 - Version: 1.0
 */
enum RatingScore
{
    case  Excellent, Good, Average, Acceptable, Poor
}

extension RatingScore
{
    /**
     This function converts from enum value to Int16
     - important: This function does not do validation
     - returns: Int16.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     */
    @available(iOS, introduced: 11.0, message: "convert to Int16")
    func toInt() -> Int16
    {
        switch self {
        case .Excellent:
            return 4
        case .Good:
            return 3
        case .Average:
            return 2
        case .Acceptable:
            return 1
        case .Poor:
            return 0
        }
    }
    
    /**
     This function performs int16 to Enum value converstion
     - important: This function does not do validation
     - returns: Rating. If the value is not between 1 & 5 then the default value of `Poor` is returned.
     - parameter input: This is the number to be converted.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     */
    @available(iOS, introduced: 11.0, message: "background fetch function")
    static func generate(withNumber input : Int16) -> RatingScore
    {
        switch input {
        case 4:
            return .Excellent
        case 3:
            return .Good
        case 2:
            return .Average
        case 1:
            return .Acceptable
        case 0:
            return .Poor
        default:
            return .Poor
        }
    }
}
