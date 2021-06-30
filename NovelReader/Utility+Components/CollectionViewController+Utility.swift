//
//  CollectionViewController+Utility.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/09/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

// default collectionView SectionInset
private var defaultSectionInset: UIEdgeInsets {
    UIEdgeInsets(top: 25, left: 20, bottom: 10, right: 20)
}

extension UIViewController {
    // MARK: SetUp UICollectionView
    public func sectionInset() -> UIEdgeInsets {
        defaultSectionInset
    }

    @objc
    var flowLayout: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = sectionInset()
        layout.headerReferenceSize = CGSize(width: 0, height: 50)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        return layout
    }
}

extension UICollectionViewCell {
    open override
    func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        var newFrame = layoutAttributes.frame
        let requiredWidth = ceil(screenWidth) - (defaultSectionInset.left + defaultSectionInset.right)
        newFrame.size = systemLayoutSizeFitting(CGSize(width: requiredWidth, height: 200),
                                                withHorizontalFittingPriority: .required,
                                                verticalFittingPriority: .fittingSizeLevel)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
