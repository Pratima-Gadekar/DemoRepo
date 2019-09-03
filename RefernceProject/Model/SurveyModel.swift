//
//  SurveyModel.swift
//  FinalProject
//
//  Created by Arun Patwardhan on 08/08/18.
//  Copyright © 2018 Amaranthine. All rights reserved.
//

import Foundation

/**
 This struct represents a single Rating from the customer.
 
 - Author: Arun Patwardhan
 - Version: 1.0
 */
struct RatingInfo
{
    var foodRating      : RatingScore
    var ambienceRating  : RatingScore
    var serviceRating   : RatingScore
}

/**
This struct represents a single Response from the customer.
 
 - Author: Arun Patwardhan
 - Version: 1.0
 */
struct SurveyModel
{
    var name            : String
    var dateOfBirth     : Date
    var email           : String
    var phone           : String
    var ratings         : RatingInfo
    var dateOfSurvey    : Date
}
