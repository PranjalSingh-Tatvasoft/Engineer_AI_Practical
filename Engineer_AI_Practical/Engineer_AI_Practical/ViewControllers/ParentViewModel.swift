//
//  ParentViewModel.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import Foundation

protocol Statefull {
    @discardableResult
    func loading(loading : (()->Void)?) -> Statefull
    
    @discardableResult
    func `catch`(failure : ((WebError)->Void)?) -> Statefull
    
    @discardableResult
    func success(success : (()->Void)?) -> Statefull
    
    @discardableResult
    func finish(finish : (()->Void)?) -> Statefull
    
}

class ParentViewModel {
    var _loading : (()->Void)?
    var _success : (()->Void)?
    var _failure : ((WebError)->Void)?
    var _finish : (()->Void)?
    
}

extension ParentViewModel : Statefull {
    @discardableResult
    func loading(loading: (() -> Void)?) -> Statefull {
        self._loading = loading
        return self
    }
    
    @discardableResult
    func `catch`(failure: ((WebError) -> Void)?) -> Statefull {
        self._failure = failure
        return self
    }
    
    @discardableResult
    func success(success: (() -> Void)?) -> Statefull {
        self._success = success
        return self
    }
    
    @discardableResult
    func finish(finish: (() -> Void)?) -> Statefull {
        self._finish = finish
        return self
    }
    
}
