//
//  NRRecentNovelCollectionViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 28/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import UIKit

class NRRecentNovelCollectionViewCell: UICollectionViewCell, NRConfigureNovelCellProtocol {
    @IBOutlet
    private weak var novelTitle: FTLabel?
    @IBOutlet
    private weak var lastUpdateTitleLabel: FTLabel?
    @IBOutlet
    private weak var lastUpdateTimeLabel: FTLabel?

    var collectionView: UICollectionView?
    var indexPath: IndexPath?
    var novelItem: NRNovel?

    func configureContent(content: AnyObject, view: UICollectionView?, indexPath: IndexPath?) {
        guard let novel = content as? NRNovel else {
            return
        }
        
        novelTitle?.text = novel.title
        // novelTitle?.isLinkUnderLineEnabled = true

        lastUpdateTitleLabel?.text = "Last Update:"
        lastUpdateTimeLabel?.text = novel.lastUpdated

        novelItem = novel
        self.collectionView = view
        self.indexPath = indexPath
    }
}
