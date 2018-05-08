//
//  NRProtocalUtility.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

protocol NRConfigureNovelCellProtocal {
    func configureContent(novel: NRNovel)
    func getSize(baseView: UIView) -> CGSize
}

extension NRConfigureNovelCellProtocal where Self: UIView {

    func getSize(baseView: UIView) -> CGSize {

        let compressedSize = self.systemLayoutSizeFitting(UILayoutFittingCompressedSize)

        if (compressedSize.width*2 + 15*3) < baseView.frame.width/2 {
            return CGSize(width: compressedSize.width, height: compressedSize.height)
        }

        let size = self.systemLayoutSizeFitting( CGSize(width: baseView.frame.width - 30, height: CGFloat.greatestFiniteMagnitude),
                                                 withHorizontalFittingPriority: UILayoutPriority.required,
                                                 verticalFittingPriority: UILayoutPriority.fittingSizeLevel)

        return CGSize(width: baseView.frame.width - 30, height: size.height)

    }
}
