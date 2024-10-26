//
//  NovelDetailsView.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 27/06/21.
//  Copyright © 2021 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NovelDetailsView: UITableViewHeaderFooterView {
    
    @IBOutlet
    private var titleLabel: UILabel?
    @IBOutlet
    private var authorLabel: UILabel?
    @IBOutlet
    private var contentImageView: UIImageView?
    @IBOutlet
    private var statusLabel: UILabel?
    @IBOutlet
    private var viewsLabel: UILabel?
    @IBOutlet
    private var descriptionLabel: UILabel?

    func configureContent(content: AnyObject) {
         guard let novel = content as? NovelModel else { return }
//        if let url = novel.imageURL {
//            self.contentImageView?.downloadedFrom(url, defaultImage: nil)
//        }
        self.titleLabel?.text = novel.title
        self.authorLabel?.text = novel.lastUpdated
        self.statusLabel?.text = novel.status
        self.viewsLabel?.text = novel.views
        self.descriptionLabel?.text = novel.contentDescription
    }
}
