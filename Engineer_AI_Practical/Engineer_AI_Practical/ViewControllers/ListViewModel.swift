//
//  ListViewModel.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import Foundation

final class ListViewModel : ParentViewModel {
    
    //MARK: - Variables
    private let interactor : GetListByDateInteractor!
    var pageNumber = 0
    var isDataLoading = false
    var isMoreData = false
    var numberOfPages : Int?
    var arrayOfLists : [GetLists] = []
    
    override init() {
        self.interactor = GetListByDateInteractor()
    }
    
    //MARK : Method for calling webservice
    func getListByDate(page : Int) {
        self.isDataLoading = true
        let parameter = ["tags" : "story",
                         "page" : "\(page)"]
        self._loading?()
        self.interactor.getListByDate(parameter: parameter) { (lists, pages, error) in
            if let lists = lists {
                if self.pageNumber == 0 {
                    self.arrayOfLists = lists
                }
                else {
                    self.arrayOfLists.append(contentsOf: lists)
                }
                self.numberOfPages = pages
                self._success?()
            }
            else {
                if let error = error {
                    self._failure?(error)
                }
            }
            self._finish?()
            self.isDataLoading = false
        }
    }
}
