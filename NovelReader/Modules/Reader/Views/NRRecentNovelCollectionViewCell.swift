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
        
        novelTitle?.isEnabled = true
        novelTitle?.text = novel.title
        novelTitle?.text = "<p>Follow @krelborn or #visit <a href=\"www.W3Schools.1.com\">Visit W3Schools</a> #visit <a href=\"www.W3Schools.2.com\">Visit W3Schools</a> #visit <a href=\"www.W3Schools.3.com\">Visit W3Schools</a> #visit <a href=\"www.W3Schools.4.com\">Visit W3Schools</a></p>"

        novelTitle?.linkHandler = { link in
            print(link.linkURL)
        }
        
        lastUpdateTitleLabel?.text = "Last Update:"
        lastUpdateTimeLabel?.text = novel.lastUpdated

        novelItem = novel
        self.collectionView = view
        self.indexPath = indexPath
    }
}
