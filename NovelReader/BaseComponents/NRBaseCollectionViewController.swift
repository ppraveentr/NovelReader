//
//  NRBaseCollectionViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/09/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

fileprivate var defaultSectionInset: UIEdgeInsets {
    get {
        return UIEdgeInsets(top: 15, left: 20, bottom: 10, right: 20)
    }
}

class NRBaseCollectionViewController: FTBaseCollectionViewController {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.hidesBottomBarWhenPushed = true
    }

    // MARK: SetUp UICollectionView
    func sectionInset() -> UIEdgeInsets {
        return defaultSectionInset
    }

    func estimatedItemSize() -> CGSize {
        return CGSize(width: FTScreenWidth, height: 20)
    }

    override func flowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = estimatedItemSize()
        layout.sectionInset = sectionInset()
        layout.headerReferenceSize = CGSize(width:0, height:45)
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }

    func setupColletionView() {

        // Relaod collectionView on exit
        defer {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        // Setup collectionView once
        guard self.delegate == nil else {
            return
        }

        collectionView.backgroundColor = .clear
        collectionView.backgroundView?.backgroundColor = .clear

        // Collection delegates
        self.dataSource = self
        self.delegate = self
    }

}

extension UICollectionViewCell {

    override open func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
        -> UICollectionViewLayoutAttributes {

            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = ceil(FTScreenWidth) - (defaultSectionInset.left + defaultSectionInset.right)
            newFrame.size.height = ceil(size.height)
            layoutAttributes.frame = newFrame
            return layoutAttributes
    }

}
