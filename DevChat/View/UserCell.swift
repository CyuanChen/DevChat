//
//  UserCell.swift
//  DevChat
//
//  Created by PeterChen on 2017/10/23.
//  Copyright © 2017年 PeterChen. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var checkImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    
    var showing = false

    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool) {
        self.emailLabel.text = email
        self.profileImage.image = image
        if isSelected {
            self.checkImage.isHidden = false
        } else {
            self.checkImage.isHidden = true
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false {
                self.checkImage.isHidden = false
                showing = true
            } else {
                self.checkImage.isHidden = true
                showing = false
            }
        }
    }
    
}









