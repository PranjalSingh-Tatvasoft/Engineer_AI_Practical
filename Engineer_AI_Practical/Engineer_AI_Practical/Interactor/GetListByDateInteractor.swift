//
//  GetListByDateInteractor.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import Foundation

public class GetLists {
    let createdAt : String
    let title : String
    var status : Bool
    
    init(list : Lists) {
        self.createdAt = list.created_at ?? ""
        self.title = list.title ?? ""
        self.status = false
    }
    
}

class GetListByDateInteractor {
    func getListByDate(parameter : [String : Any], completion : @escaping ([GetLists]?, Int?, WebError?) -> Void) {
        APIManager.shared.fetchData(router: .getListByDate(parameter), onSuccess: { (response) in
            if let codableData = response.data as? [[String:Any]] {
                var arrayOfList : [Lists] = []
                codableData.forEach{ (lists) in
                    do
                    {
                        let jsonData = try JSONSerialization.data(withJSONObject: lists, options: .prettyPrinted)
                        let list = try JSONDecoder().decode(Lists.self, from: jsonData)
                        arrayOfList.append(list)
                    }
                    catch {
                        print("Something went wrong in codable casting.")
                    }
                }
                completion(self.getLists(list: arrayOfList), response.pages, nil)
            }
        }, onfailure: { error in
            completion(nil,nil,error)
        })
    }
    
    private func getLists(list : [Lists]? = nil) -> [GetLists]? {
        if let list = list {
            return list.compactMap{GetLists(list: $0)}
        }
        else {
            return nil
        }
    }
}

