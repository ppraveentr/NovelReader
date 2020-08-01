//
//  NRNovelTableViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

public extension UIImageView {
    
    func imageWithGradient(img: UIImage!) -> UIImage {
        
        UIGraphicsBeginImageContext(img.size)
        let context = UIGraphicsGetCurrentContext()
        
        img.draw(at: CGPoint(x: 0, y: 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 1.0]
        
        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        let colors = [top, bottom] as CFArray
        
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations)
        
        let startPoint = CGPoint(x: img.size.width / 2, y: 0)
        let endPoint = CGPoint(x: img.size.width / 2, y: img.size.height)
        
        if let context = context, let gradient = gradient {
            context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(0)))
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image.forceUnwrapped
    }
}

class NRNovelCollectionViewCell: UICollectionViewCell, ConfigureNovelCellProtocol {
 
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
