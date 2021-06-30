//
//  NovelCollectionViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NovelCollectionViewCell: UICollectionViewCell {
    @IBOutlet
    private var titleLabel: UILabel?
    @IBOutlet
    private var contentImageView: UIImageView?

    @IBOutlet
    private var chapterLabel: UILabel?
    @IBOutlet
    private var genresLabel: UILabel?
    @IBOutlet
    private var typeLabel: UILabel?
    @IBOutlet
    private var statusButton: UIButton?
    @IBInspectable
    private var defaultImage: UIImage?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset image
        self.contentImageView?.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateShadowPathIfNeeded()
    }
}

extension NovelCollectionViewCell: ConfigureNovelCellProtocol {
    func configureContent(content: AnyObject, indexPath: IndexPath? = nil) {
        guard let novel = content as? NovelModel else { return }
        self.theme = ThemeStyle.defaultStyle
        if let url = novel.imageURL {
            self.contentImageView?.downloadedFrom(link: url, defaultImage: defaultImage)
        }
        self.titleLabel?.text = novel.title
        self.chapterLabel?.text = novel.author
        if var genres = novel.genres?.joined(separator: ", ") {
            genres = "Genres: " + genres
            self.genresLabel?.text = genres
        }
        self.typeLabel?.text = novel.novelType
        self.statusButton?.setTitle(novel.status ?? "", for: .normal)
    }
}
