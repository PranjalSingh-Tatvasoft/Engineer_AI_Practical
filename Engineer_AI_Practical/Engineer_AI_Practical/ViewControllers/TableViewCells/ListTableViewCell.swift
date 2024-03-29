//
//  ListTableViewCell.swift
//  Engineer_AI_Practical
//
//  Created by PCQ166 on 20/12/19.
//  Copyright © 2019 PCQ166. All rights reserved.
//

import UIKit

protocol ListTableViewCellDelegate : class {
    func didChangeStatus(status : Bool, cell : ListTableViewCell)
}

final class ListTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var statusSwitch: UISwitch!
    
    //MARK: - properties
    weak var delegate : ListTableViewCellDelegate?
    
    //MARK: - Set Value
    var list : GetLists! {
        didSet {
            self.titleLabel.text = list.title
            self.statusSwitch.isOn = list.status
            if let date = list.createdAt.stringToDate {
                self.dateLabel.text = date.dateToStringLong
            }
        }
    }
  
    @IBAction func statusChanged(_ sender: UISwitch) {
        self.delegate?.didChangeStatus(status: sender.isOn, cell: self)
    }
}
