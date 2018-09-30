//
//  NRRecentNovelCollectionViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 28/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import UIKit

class NRRecentNovelCollectionViewCell: UICollectionViewCell, NRConfigureNovelCellProtocol {
    @IBOutlet weak var novelTitle: FTLabel?
    @IBOutlet weak var lastUpdateTitleLabel: FTLabel?
    @IBOutlet weak var lastUpdateTimeLabel: FTLabel?

    var collectionView: UICollectionView? = nil
    var indexPath: IndexPath? = nil
    var novelItem: NRNovel? = nil

    func configureContent(novel: NRNovel, view: UICollectionView? = nil, indexPath: IndexPath? = nil) {
        novelTitle?.text = novel.title
        // novelTitle?.isLinkUnderLineEnabled = true

        lastUpdateTitleLabel?.text = "Last Update:"
        lastUpdateTimeLabel?.text = novel.lastUpdated

        novelItem = novel
        self.collectionView = view
        self.indexPath = indexPath
    }
    
}
