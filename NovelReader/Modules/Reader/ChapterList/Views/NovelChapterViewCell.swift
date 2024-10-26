//
//  NovelChapterViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NovelChapterViewCell: UITableViewCell {
    @IBOutlet
    private var chapterDate: UILabel?
    @IBOutlet
    private var titleLabel: UILabel?
}

extension NovelChapterViewCell: ConfigureNovelCellProtocol {
    func configureContent(content: AnyObject, indexPath: IndexPath?) {
        guard let novel = content as? NovelChapterModel else { return }
        self.titleLabel?.text = novel.shortTitle ?? novel.title
        self.chapterDate?.text = novel.releaseDate
    }
}
