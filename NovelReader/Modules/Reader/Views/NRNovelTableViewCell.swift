//
//  NRNovelTableViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRNovelTableViewCell: UITableViewCell {
    
    @IBOutlet var chapterDate: FTLabel?
    @IBOutlet var titleLabel: FTLabel?
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        self.addBorder()
//    }
    
    func configureContent(content: AnyObject) {
        guard let novel = content as? NRNovelChapter else {
            return
        }
        self.titleLabel?.text = novel.shortTitle ?? novel.title
        self.chapterDate?.text = novel.releaseDate 
    }
    
//    override func draw(_ rect: CGRect) {
//        
//        self.contentView.layer.cornerRadius = 5
//        self.contentView.layer.masksToBounds = true
//        self.layer.borderWidth = 2.0
//        
//        super.draw(UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(10, 10 , 10, 10)))
//    }
    
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
    
//    override var intrinsicContentSize: CGSize {
//        get{
//            return (self.titleLabel?.intrinsicContentSize)!
//        }
//    }
    
}
