//
//  IndexPath+Extention.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 24/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

extension IndexPath {
    public static func == (lhs: IndexPath, rhs: IndexPath) -> Bool {
        return lhs.row == rhs.row && lhs.section == rhs.section
    }
}

extension Optional {
    var forceUnwrapped: Wrapped! {
        return self
    }
}
