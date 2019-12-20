//
//  WebError.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import Foundation

enum WebError : Error {
    case noInternet
    case hostFail
    case noData
    case parseFail
    case timeout
    case unAuthorised
    case cancel
    case unknown
    case custom(String?)
    
    var errorMessage : String? {
        switch self {
        case .cancel:
            return "Cancelled."
        case .noData:
            return "No Data Found."
        case .noInternet:
            return "Internet is not available.."
        case .hostFail:
            return "Host failed."
        case .parseFail:
            return "Parsing failed."
        case .timeout:
            return "Request Timeout."
        case .unAuthorised:
            return "Unauthorised."
        case .unknown:
            return "Something went wrong."
        case .custom(let error):
            return error
        }
    }
}

