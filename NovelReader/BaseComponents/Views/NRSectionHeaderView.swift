//
//  NRSectionHeaderView.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 24/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRSectionHeaderView: UICollectionReusableView {

    var titleString: String?
    var tapAction: FTViewControllerCompletionBlock?

    // Left Button
    @IBOutlet
    fileprivate var buttonLeft: UIButton?
    @IBOutlet
    fileprivate var titleLabel: UILabel?
    // Right Button
    @IBOutlet
    fileprivate var buttonRight: UIButton?
    fileprivate var contentXIBView: UIView?

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
            self.buttonLeft?.isHidden = false
            self.buttonLeft?.setImage(image, for: .normal)
        }
        else {
            self.buttonLeft?.removeSubviews()
        }

        // Left Button
        titleLabel?.text = title
    }

    func setRightButton(title: String? = nil, image: UIImage? = nil, tapAction: FTViewControllerCompletionBlock? = nil) {
        // Right Button
        self.buttonRight?.isHidden = false
        if !title.isNilOrEmpty {
            self.buttonRight?.setTitle(title, for: .normal)
            self.buttonRight?.setImage(image, for: .normal)
        }
        else {
            self.buttonRight?.setBackgroundImage(image, for: .normal)
        }

        // Button ACtion
        if tapAction != nil {
            self.tapAction = tapAction
            self.buttonRight?.addTapActionBlock {
                self.tapAction?(true, nil)
            }
        }
    }

    // MARK: Customise View
    var rightButton: UIButton? {
        return buttonRight
    }
}
