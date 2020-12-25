//
//  UIViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

extension UIViewController {
    func hideBottomBar(_ isHidden: Bool) {
        self.tabBarController?.tabBar.isHidden = isHidden
    }
}
