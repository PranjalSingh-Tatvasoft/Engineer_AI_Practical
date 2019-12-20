//
//  UITableView+Extension.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    private func register<T: UITableViewCell>(_ : T.Type, reuseIdentifier : String? = nil) {
        register(UINib.init(nibName: String(describing: T.self), bundle: Bundle.main), forCellReuseIdentifier: String(describing: T.self))
    }
    
    func dequeueCellFromNIB<T: UITableViewCell>(_ : T.Type) -> T {
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T {
            return cell
        }
        else {
            register(T.self)
            return dequeueCellFromNIB(T.self)
        }
    }
}
