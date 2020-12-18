//
//  NovelTableViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NovelTableViewCell: UITableViewCell {
    
    @IBOutlet
    private var chapterDate: UILabel?
    @IBOutlet
    private var titleLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addBorder()
    }
    
    func configureContent(content: AnyObject) {
        guard let novel = content as? NovelChapterModel else { return }
        self.titleLabel?.text = novel.shortTitle ?? novel.title
        self.chapterDate?.text = novel.releaseDate 
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
