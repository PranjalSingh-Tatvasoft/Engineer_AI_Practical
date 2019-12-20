//
//  BaseResponse.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import Foundation
import Alamofire

class BaseResponse {
    
    let data : Any?
    let pages : Int?
    
    init(parameter : [String : Any]) {
        self.data = parameter["hits"] as? [[String : Any]]
        self.pages = parameter["nbPages"] as? Int
    }
}
