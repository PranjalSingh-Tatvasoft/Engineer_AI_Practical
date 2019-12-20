//
//  Router.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import Foundation
import Alamofire

protocol Routable {
    var parameters  : Parameters? {get}
    var path        : String {get}
    var httpMethod  : HTTPMethod? {get}
    
}

enum Router : Routable {
    case getListByDate(Parameters)
}

extension Router {
    var path: String {
        switch self {
        case .getListByDate:
            return self.baseURL + "search_by_date"
        }
    }
        
}

extension Router {
    var httpMethod: HTTPMethod? {
        switch self {
        case .getListByDate:
            return .get
        }
    }
        
}

extension Router {
    var parameters: Parameters? {
        switch self {
        case .getListByDate(let param):
            return param
        }
    }
        
}

extension Router {
    private var baseURL : String {
        return "https://hn.algolia.com/api/v1/"
    }
    
}

