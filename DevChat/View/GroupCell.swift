//
//  GroupCell.swift
//  DevChat
//
//  Created by PeterChen on 2017/10/23.
//  Copyright © 2017年 PeterChen. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var groupDescLabel: UILabel!
    @IBOutlet weak var memberCountLabel: UILabel!
    
    
    func configureCell(title: String, description: String, memberCount: Int) {
        self.groupTitleLabel.text = title
        self.groupDescLabel.text = description
        self.memberCountLabel.text = "\(memberCount) members."
    }
}

