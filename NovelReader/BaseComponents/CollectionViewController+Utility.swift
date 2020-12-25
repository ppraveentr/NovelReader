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
    return UIEdgeInsets(top: 15, left: 20, bottom: 10, right: 20)
}

extension UIViewController {

    // MARK: Show/Hide Tabbar, View lifecycle
//    func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.hidesBottomBarWhenPushed = false
//    }
//
//    func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.hidesBottomBarWhenPushed = true
//    }

    // MARK: SetUp UICollectionView
    public func sectionInset() -> UIEdgeInsets {
        return defaultSectionInset
    }

    public func estimatedItemSize() -> CGSize {
        return CGSize(width: screenWidth - (sectionInset().left + sectionInset().right), height: 20)
    }

    @objc
    var flowLayout: UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = estimatedItemSize()
        if #available(iOS 10.0, *) {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        } 
        layout.sectionInset = sectionInset()
        layout.headerReferenceSize = CGSize(width: 0, height: 45)
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }

    func configureColletionView(_ delegate: UICollectionViewDelegate? = nil, _ source: UICollectionViewDataSource? = nil) {
        guard let self = self as? CollectionViewControllerProtocol else {
            return
        }
        // Relaod collectionView on exit
        defer {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        // Setup collectionView once
        guard self.collectionView.delegate == nil else {
            return
        }

        self.collectionView.theme = ThemeStyle.defaultStyle

        // Collection delegates
        self.collectionView.dataSource = source
        self.collectionView.delegate = delegate
    }
}

extension UICollectionViewCell {

    override open func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
        -> UICollectionViewLayoutAttributes {
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = ceil(screenWidth) - (defaultSectionInset.left + defaultSectionInset.right)
            newFrame.size.height = ceil(size.height)
            layoutAttributes.frame = newFrame
            return layoutAttributes
    }
}
