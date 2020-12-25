//
//  RecentNovelCollectionViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 28/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import UIKit

class RecentNovelCollectionViewCell: UICollectionViewCell {
    @IBOutlet
    private weak var novelTitle: UILabel?
    @IBOutlet
    private weak var lastUpdateTitleLabel: UILabel?
    @IBOutlet
    private weak var lastUpdateTimeLabel: UILabel?

    weak var novelItem: NovelModel?
}

extension RecentNovelCollectionViewCell: ConfigureNovelCellProtocol {
    func configureContent(content: AnyObject, indexPath: IndexPath?) {
        guard let novel = content as? NovelModel else { return }
        self.theme = ThemeStyle.defaultStyle
        novelItem = novel
        novelTitle?.text = novel.title
        lastUpdateTitleLabel?.text = "Last Update:"
        lastUpdateTimeLabel?.text = novel.lastUpdated
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateShadowPathIfNeeded()
    }
}
