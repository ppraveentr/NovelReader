//
//  SelectionCollectionViewCell.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 23/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class SelectionCollectionViewCell: UICollectionViewCell {

    @IBOutlet
    private var titleLabel: UILabel?
    @IBOutlet
    private var checkMarkImage: UIImageView?

    override var isSelected: Bool {
        didSet {
            self.titleLabel?.isEnabled = isSelected
            checkMarkImage?.isHidden = !isSelected

            if isSelected {
                self.layer.borderColor = AppTheme.navigationBarColor.cgColor
            }
            else {
                self.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }

    func addBorder() {
        self.layer.cornerRadius = 8

        // border
        self.layer.borderColor = AppTheme.navigationBarColor.cgColor
        self.layer.borderWidth = 0.5

        // drop shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
        -> UICollectionViewLayoutAttributes {
            setNeedsLayout()
            layoutIfNeeded()

            let size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = ceil(size.width)
            newFrame.size.height = ceil(size.height)
            layoutAttributes.frame = newFrame
            return layoutAttributes
    }
}

extension SelectionCollectionViewCell: ConfigureNovelCellProtocol {
    func configureContent(content: AnyObject, indexPath: IndexPath?) {
        if let searchFilter = content as? FilterModel {
            self.titleLabel?.text = searchFilter.type
        }
        setNeedsLayout()
        layoutIfNeeded()
    }
}
