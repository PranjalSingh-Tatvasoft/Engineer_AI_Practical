//
//  String+Extension.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import Foundation

extension String {
    var stringToDate : Date? {
        return DateFormatter.dateFormatterLong.date(from: self)
    }
}
