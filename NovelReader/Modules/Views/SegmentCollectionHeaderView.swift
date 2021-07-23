//
//  SegmentCollectionHeaderView.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class SegmentCollectionHeaderView: UICollectionReusableView {
    lazy var segmentedControl: ScrollableSegmentControl = {
        let view = ScrollableSegmentControl()
        self.pin(view: view, edgeOffsets: UIEdgeInsets(20, 10, -20, 0))
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    func configureUI() {
        self.theme = ThemeStyle.defaultStyle.rawValue
        setupSegmentView()
    }

    func setupSegmentView(_ items: [String] = [ Constants.recentUpdateString, Constants.topViews ]) {
        for (index, obj) in items.enumerated() {
            segmentedControl.insertSegment(withTitle: obj, image: nil, theme: "segment", at: index)
        }
    }
}
