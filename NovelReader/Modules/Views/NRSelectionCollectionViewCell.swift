//
//  NRSelectionCollectionViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 23/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRSelectionCollectionViewCell: UICollectionViewCell, NRConfigureNovelCellProtocol {

    @IBOutlet var titleLabel: FTLabel?
    @IBOutlet var checkMarkImage: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addBorder()
    }

    override var isSelected: Bool {
        didSet {
            checkMarkImage?.isHidden = !isSelected
        }
    }

    func configureContent(content: AnyObject) {
        if let searchFilter = content as? NRFilterModel {
            self.titleLabel?.text = searchFilter.data
        }
    }

    func addBorder() {
        self.layer.cornerRadius = 8

        // border
        self.layer.borderColor = kNavigationBarColor.cgColor
        self.layer.borderWidth = 0.5

        // drop shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
    }

}
