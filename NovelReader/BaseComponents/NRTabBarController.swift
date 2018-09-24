//
//  NRTabBarController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRTabBarController: FTBaseTabBarController {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.hidesBottomBarWhenPushed = true
    }
}
