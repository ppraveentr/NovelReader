//
//  NRNovelTableViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class FTImageView: UIImageView {
    
    var grain: UIImage? = nil

//    override var image: UIImage?{
//        didSet{
//            if grain == nil {
//                
//                    grain = self.imageWithGradient(img: image)
//                self.image = grain
//                
//                if image != nil {
//                    self.superview?.backgroundColor = image?.getColor( a: 25)
//                }
//            }
//        }
//    }
    
    func imageWithGradient(img:UIImage!) -> UIImage {
        
        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()
        
        img.draw(at: CGPoint(x: 0, y: 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0.0, 1.0]
        
        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        let colors = [top, bottom] as CFArray
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)
        
        let startPoint = CGPoint(x: img.size.width/2, y: 0)
        let endPoint = CGPoint(x: img.size.width/2, y: img.size.height)
        
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
}

class NRNovelCollectionViewCell: UICollectionViewCell, NRConfigureNovelCellProtocal {

    @IBOutlet var titleLabel: FTLabel?
    @IBOutlet var contentImageView: FTImageView?
    @IBOutlet var chapterLabel: FTLabel?
    @IBOutlet var lastUpdateLabel: FTLabel?
    @IBOutlet var viewsButton: FTButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addBorder()
    }
    
    func configureContent(novel: NRNovel) {
        if let url = novel.imageURL {
         self.contentImageView?.downloadedFrom(link: url)
        }
        self.titleLabel?.text = novel.title
        self.chapterLabel?.text = novel.lastChapter
        self.lastUpdateLabel?.text = novel.lastUpdated
        self.viewsButton?.setTitle(novel.views, for: .normal)
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
