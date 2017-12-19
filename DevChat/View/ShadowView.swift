//
//  ShadowView.swift
//  DevChat
//
//  Created by PeterChen on 2017/10/16.
//  Copyright © 2017年 PeterChen. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }
}
