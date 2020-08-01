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
    var imageViewCompletionHandler: ImageViewComletionHandler?

    @IBOutlet
    private var chapterLabel: UILabel?
    @IBOutlet
    private var lastUpdateLabel: UILabel?
    @IBOutlet
    private var viewsButton: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addBorder()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset image
        self.contentImageView?.image = nil
        self.imageViewCompletionHandler = nil
    }
    
    func configureContent(content: AnyObject, view: UICollectionView? = nil, indexPath: IndexPath? = nil) {
        guard let novel = content as? NovelModel else {
            return
        }
        
        // Reset image
        self.imageViewCompletionHandler = { image in
            self.contentImageView?.image = image
        }
        if let url = novel.imageURL {
            self.contentImageView?.downloadedFrom(link: url,
                                                  comletionHandler: self.imageViewCompletionHandler)
        }

        self.titleLabel?.text = novel.title
        self.chapterLabel?.text = novel.lastChapter
        self.lastUpdateLabel?.text = novel.lastUpdated
        self.viewsButton?.setTitle(novel.views ?? "100", for: .normal)
    }
    
    func addBorder() {
        self.layer.cornerRadius = 8
        
        // border
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5

        // drop shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
}
