//
//  NRProtocolUtility.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

protocol NRConfigureNovelCellProtocol {
    func configureContent(novel: NRNovel)
    func configureContent(novel: NRNovel, view: UICollectionView?, indexPath: IndexPath?)
    func getSize(baseView: UIView) -> CGSize
}

extension NRConfigureNovelCellProtocol where Self: UIView {

    func configureContent(novel: NRNovel) { }
    func configureContent(novel: NRNovel, view: UICollectionView?, indexPath: IndexPath?) { }

    func getSize(baseView: UIView) -> CGSize {
        
        let compressedSize = self.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        if (compressedSize.width*2 + 15*3) < baseView.frame.width/2 {
            return CGSize(width: compressedSize.width, height: compressedSize.height)
        }

        let width = baseView.frame.width

        let size = self.systemLayoutSizeFitting( CGSize(width: width, height: 0),
                                                 withHorizontalFittingPriority: UILayoutPriority.required,
                                                 verticalFittingPriority: UILayoutPriority.fittingSizeLevel)

        return CGSize(width: width - 38, height: size.height)

    }
}
