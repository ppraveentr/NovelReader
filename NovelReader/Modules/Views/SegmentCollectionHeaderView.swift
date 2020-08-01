//
//  SegmentCollectionHeaderView.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class SegmentCollectionHeaderView: UICollectionReusableView {
    var segmentedControl: UISegmentedControl? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSegmentView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupSegmentView()
    }

    func setupSegmentView(_ items: [Any] = [ kRecentUpdateString, kTopViews ]) {
        // Remove previous segment
        segmentedControl?.removeSubviews()
        segmentedControl = UISegmentedControl(items: items) { ftLog($0) }
        if let segment = segmentedControl {
            self.pin(view: segment, edgeOffsets: UIEdgeInsets(10))
        }
        
       setupViewTheme()
    }
    
    func setupViewTheme() {
        self.theme = ThemeStyle.defaultStyle
        segmentedControl?.theme = ThemeStyle.defaultStyle
    }
}
