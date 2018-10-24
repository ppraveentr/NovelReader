//
//  NRSectionHeaderView.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 24/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRSectionHeaderView: UICollectionReusableView {

    var titleString: String? = nil

    // Left Button
    @IBOutlet
    fileprivate var leftButton_: FTButton? = nil
    @IBOutlet
    fileprivate var titleLabel: FTLabel? = nil
    // Right Button
    @IBOutlet
    fileprivate var rightButton_: FTButton? = nil
    var tapAction: FTAppBaseCompletionBlock? = nil
    fileprivate var contentXIBView: UIView? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupView() {
        self.backgroundColor = .clear
        contentXIBView = self.xibSetup(className: NRSectionHeaderView.self)
        contentXIBView?.theme = self.theme
    }

    func setSectionHeader(title: String? = nil, image: UIImage? = nil) {
        self.titleString = title

        if let image = image {
            self.leftButton_?.isHidden = false
            self.leftButton_?.setImage(image, for: .normal)
        } else {
            self.leftButton_?.removeSubviews()
        }

        // Left Button
        titleLabel?.text = title
    }

    func setRightButton(title: String? = nil, image: UIImage? = nil, tapAction: FTAppBaseCompletionBlock? = nil) {
        // Right Button
        self.rightButton_?.isHidden = false
        if !title.isNilOrEmpty {
            self.rightButton_?.setTitle(title, for: .normal)
            self.rightButton_?.setImage(image, for: .normal)
        } else {
            self.rightButton_?.setBackgroundImage(image, for: .normal)
        }

        // Button ACtion
        if tapAction != nil {
            self.tapAction = tapAction
            self.rightButton_?.addTapActionBlock {
                self.tapAction?(true, nil)
            }
        }
    }

    // MARK: Customise View
    var rightButton: FTButton? {
        return rightButton_
    }

}
