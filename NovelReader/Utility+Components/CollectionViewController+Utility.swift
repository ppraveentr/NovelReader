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
        layout.headerReferenceSize = CGSize(width: 0, height: 45)
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }

    func configureColletionView(_ delegate: UICollectionViewDelegate? = nil, _ source: UICollectionViewDataSource? = nil) {
        guard let self = self as? CollectionViewControllerProtocol else { return }
        // Relaod collectionView on exit
        defer {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        // Setup collectionView once
        guard self.collectionView.delegate == nil else { return }
        self.collectionView.theme = ThemeStyle.defaultStyle
        // Collection delegates
        self.collectionView.dataSource = source
        self.collectionView.delegate = delegate
    }
}

extension UICollectionViewCell {
    open override
    func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        var newFrame = layoutAttributes.frame
        let requiredWidth = ceil(screenWidth) - (defaultSectionInset.left + defaultSectionInset.right)
        newFrame.size = systemLayoutSizeFitting(CGSize(width: requiredWidth, height: .greatestFiniteMagnitude),
                                                withHorizontalFittingPriority: .required,
                                                verticalFittingPriority: .fittingSizeLevel)
        layoutAttributes.frame = newFrame
        return layoutAttributes
    }
}
