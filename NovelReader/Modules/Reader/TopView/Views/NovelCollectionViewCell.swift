//
//  NovelCollectionViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NovelCollectionViewCell: UICollectionViewCell, ConfigureNovelCellProtocol {
 
    @IBOutlet
    private var titleLabel: UILabel?
    @IBOutlet
    private var contentImageView: UIImageView?

    @IBOutlet
    private var chapterLabel: UILabel?
    @IBOutlet
    private var lastUpdateLabel: UILabel?
    @IBOutlet
    private var viewsButton: UIButton?
    @IBInspectable
    private var defaultImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addGrayBorder()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset image
        self.contentImageView?.image = nil
    }
    
    func configureContent(content: AnyObject, view: UICollectionView? = nil, indexPath: IndexPath? = nil) {
        guard let novel = content as? NovelModel else { return }
        
        if let url = novel.imageURL {
            self.contentImageView?.downloadedFrom(link: url, defaultImage: defaultImage)
        }

        self.titleLabel?.text = novel.title
        self.chapterLabel?.text = novel.author
        self.lastUpdateLabel?.text = novel.lastUpdated
        self.viewsButton?.setTitle(novel.views ?? "", for: .normal)
    }
}
