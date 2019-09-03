//
//  MonthType.swift
//  FinalProject
//
//  Created by Arun Patwardhan on 03/11/18.
//  Copyright © 2018 Amaranthine. All rights reserved.
//

import Foundation

/**
 Months in a year
 
 *values*
 
 `January`
 
 `February`
 
 `March`
 
 `April`
 
 `May`
 
 `June`
 
 `July`
 
 `August`
 
 `September`
 
 `October`
 
 `November`
 
 `December`
 
 *functions*
 
 `static func enumFrom(Date inputDate : Date) -> MonthType`
 
 Used to get the enum value from Date type.
 
 `func toString() -> String`
 
 String generator
 
 - Author: Arun Patwardhan
 - Version: 1.0
 */
enum MonthType
{
    case January, February, March, April, May, June, July, August, September, October, November, December
}

/**
 Used to extract the Month from the Date type.
 
 - Author: Arun Patwardhan
 - Version: 1.0
 */
extension Date
{
    /**
     This function extracts the month from the Date
     - important: This function does not do validation
     - returns: String.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     */
    func getMonthName() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let strMonth = dateFormatter.string(from: self)
        return strMonth
    }
}

extension MonthType
{
    /**
     This function converts from Date to MonthType
     - important: This function does not do validation
     - returns: `MonthType`.
     - parameter inputDate: The date from which the MonthType will be generated
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     */
    static func enumFrom(Date inputDate : Date) -> MonthType
    {
        switch inputDate.getMonthName() {
        case "January":
            return .January
        case "February":
            return .February
        case "March":
            return .March
        case "April":
            return .April
        case "May":
            return .May
        case "June":
            return .June
        case "July":
            return .July
        case "August":
            return .August
        case "September":
            return .September
        case "October":
            return .October
        case "November":
            return .November
        case "December":
            return .December
        default:
            return .January
        }
    }
}

extension MonthType
{
    /**
     This function converts enum value to String
     - important: This function does not do validation
     - returns: `String`.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     */
    func toString() -> String
    {
        switch self {
        case .January:
            return "January "
        case .February:
            return "February "
        case .March:
            return "March "
        case .April:
            return "April "
        case .May:
            return "May "
        case .June:
            return "June "
        case .July:
            return "July "
        case .August:
            return "August "
        case .September:
            return "September "
        case .October:
            return "October "
        case .November:
            return "November "
        case .December:
            return "December "
        }
    }
}

extension MonthType
{
    /**
     This function converts from Int to MonthType
     - important: This function does not do validation.
     - note: If the `Int` value exceeds the range `0...11` then it will send `January` as the default value.
     - returns: `MonthType`.
     - parameter input: The number(`Int`) from which the MonthType will be generated
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     */
    static func enumFrom(Int input : Int) -> MonthType
    {
        switch input {
        case 0:
            return .January
        case 1:
            return .February
        case 2:
            return .March
        case 3:
            return .April
        case 4:
            return .May
        case 5:
            return .June
        case 6:
            return .July
        case 7:
            return .August
        case 8:
            return .September
        case 9:
            return .October
        case 10:
            return .November
        case 11:
            return .December
        default:
            return .January
        }
    }
    
    /**
     This function converts from `MonthType` value to `Int`
     - important: This function does not do validation
     - returns: `Int`.
     - requires: iOS 11 or later
     - Since: iOS 11
     - author: Arun Patwardhan
     - copyright: Copyright (c) Amaranthine 2015
     - version: 1.0
     */
    func intFromEnum() -> Int
    {
        switch self {
        case .January:
            return 0
        case .February:
            return 1
        case .March:
            return 2
        case .April:
            return 3
        case .May:
            return 4
        case .June:
            return 5
        case .July:
            return 6
        case .August:
            return 7
        case .September:
            return 8
        case .October:
            return 9
        case .November:
            return 10
        case .December:
            return 11
        }
    }
}
