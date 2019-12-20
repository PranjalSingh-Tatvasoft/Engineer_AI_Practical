//
//  Date+Extension.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import Foundation

extension Date {
    var dateToStringLong : String {
        return DateFormatter.dateFormatterToDisplay.string(from: self)
    }
}
