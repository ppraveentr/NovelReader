//
//  RecentNovelCollectionViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 28/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import UIKit

class RecentNovelCollectionViewCell: UICollectionViewCell, ConfigureNovelCellProtocol {
    @IBOutlet
    private weak var novelTitle: UILabel?
    @IBOutlet
    private weak var lastUpdateTitleLabel: UILabel?
    @IBOutlet
    private weak var lastUpdateTimeLabel: UILabel?

    var collectionView: UICollectionView?
    var indexPath: IndexPath?
    var novelItem: NovelModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGrayBorder()
    }
    
    func configureContent(content: AnyObject, view: UICollectionView?, indexPath: IndexPath?) {
        guard let novel = content as? NovelModel else { return }
        
        novelTitle?.isEnabled = true
        novelTitle?.text = novel.title
        
        lastUpdateTitleLabel?.text = "Last Update:"
        lastUpdateTimeLabel?.text = novel.lastUpdated

        novelItem = novel
        self.collectionView = view
        self.indexPath = indexPath
        
        novelTitle?.layoutView()
    }
}
