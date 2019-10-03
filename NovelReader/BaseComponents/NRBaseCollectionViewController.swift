//
//  NRBaseCollectionViewController.swift
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

class NRBaseCollectionViewController: FTBaseViewController, FTCollectionViewControllerProtocol {

    // MARK: Show/Hide Tabbar, View lifecycle
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidesBottomBarWhenPushed = true
    }

    // MARK: SetUp UICollectionView
    func sectionInset() -> UIEdgeInsets {
        return defaultSectionInset
    }

    func estimatedItemSize() -> CGSize {
        return CGSize(width: FTScreenWidth - (sectionInset().left + sectionInset().right), height: 20)
    }

    var flowLayout: NSObject {
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
        // Relaod collectionView on exit
        defer {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        // Setup collectionView once
        guard collectionView.delegate == nil else {
            return
        }

        collectionView.theme = FTThemeStyle.defaultStyle

        // Collection delegates
        collectionView.dataSource = source
        collectionView.delegate = delegate
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
