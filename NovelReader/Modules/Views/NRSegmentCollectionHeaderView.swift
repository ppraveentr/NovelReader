//
//  NRSegmentCollectionHeaderView.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRSegmentCollectionHeaderView: UICollectionReusableView {
    var segmentedControl: FTSegmentedControl?

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

        self.theme = FTThemeStyle.defaultStyle

        segmentedControl = FTSegmentedControl(items: items) { segment in
            FTLog(segment)
        }

        if let segment = segmentedControl {
            self.pin(view: segment, edgeOffsets: FTEdgeOffsets(10))
        }
    }
}
