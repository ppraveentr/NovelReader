//
//  View+Utility.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 23/12/20.
//  Copyright © 2020 Praveen Prabhakar. All rights reserved.
//

import Foundation

extension IndexPath {
    public static func == (lhs: IndexPath, rhs: IndexPath) -> Bool {
        lhs.row == rhs.row && lhs.section == rhs.section
    }
}

extension UIView {
    func addGrayBorder() {
        // drop shadow
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
