//
//  NRNovelDescriptionView.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 25/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRNovelDescriptionView: UITableViewHeaderFooterView {
    
    @IBOutlet
    private var titleLabel: UILabel?
    @IBOutlet
    private var descriptionLabel: UILabel?
    @IBOutlet
    private var contentImageView: UIImageView?
    
    @IBOutlet
    private var chapterLabel: UILabel?
    @IBOutlet
    private var lastUpdateLabel: UILabel?
    @IBOutlet
    private var viewsButton: UIButton?
    
    func configureContent(content: AnyObject) {
        guard let novel = content as? NRNovel else {
            return
        }

        if let url = novel.imageURL {
            self.contentImageView?.downloadedFrom(link: url )
        }
        self.titleLabel?.text = novel.title
        self.descriptionLabel?.text = novel.contentDescription

        self.chapterLabel?.text = novel.lastChapter
        self.lastUpdateLabel?.text = novel.lastUpdated
        self.viewsButton?.setTitle(novel.views, for: .normal)

        setNeedsLayout()
        layoutIfNeeded()
    }
}
