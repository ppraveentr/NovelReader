//
//  ScollableSegmentControl.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 26/06/21.
//  Copyright © 2021 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class ScrollableSegmentControl: UIScrollView {
    typealias SegmentHandler = ( (_ index: Int) -> Void )
    var handler: SegmentHandler?
    
    private var segmentsList = [SegmentData]()
    private var selectedSegment: SegmentData? {
        willSet {
            selectedSegment?.isSelected = false
        }
        didSet {
            selectedSegment?.isSelected = true
        }
    }

    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 30
        contentView.pin(view: view)
        setupScrollView(self)
        return view
    }()
}

extension ScrollableSegmentControl {
    public func insertSegment(withTitle title: String? = nil, image: UIImage? = nil,
                              theme: String, at index: Int) {
        let segment = SegmentData(title: title, image: image, theme: theme)
        segment.actionBlock = { [weak self] in
            self?.didSelectSegement(data: segment)
        }
        segmentsList.insert(segment, at: index)
        // Update View
        updateList()
    }
    
    public func removeSegment(at index: Int) {
        guard segmentsList.count > index else { return }
        segmentsList.remove(at: index)
        // Update View
        updateList()
    }
}

private extension ScrollableSegmentControl {
    func didSelectSegement(data: SegmentData) {
        selectedSegment = data
        let index: Int = segmentsList.firstIndex(of: data) ?? 0
        //setContentOffset(CGPoint(x: data.view.frame.origin.x - 100, y: 0), animated: true)
        handler?(index)
    }
    
    func updateList() {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        segmentsList.forEach { stackView.addArrangedSubview($0.view) }
        if selectedSegment == nil {
            selectedSegment = segmentsList.first
        }
    }
    
    func setupScrollView(_ scrollView: UIScrollView) {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceHorizontal = true
    }
}

// MARK: - SegmentData
private extension ScrollableSegmentControl {
    final class SegmentData: Equatable {
        var title: String?
        var theme: String?
        var image: UIImage?
        var actionBlock: ActionBlock?
        var isSelected: Bool = false {
            didSet {
                buttonView.isSelected = isSelected
                underlineView.isHidden = !isSelected
            }
        }

        init(title: String? = nil, image: UIImage? = nil, theme: String) {
            self.title = title
            self.image = image?.withRenderingMode(.alwaysTemplate)
            self.theme = theme
        }
        
        lazy var view: UIStackView = {
            let view = UIStackView(arrangedSubviews: [buttonView, underlineView])
            view.axis = .vertical
            return view
        }()
        
        lazy var underlineView: UIView = {
            let view = UIView()
            view.theme = "underline"
            view.isHidden = !isSelected
            view.setViewHeight(6, createConstraint: true)
            return view
        }()
        
        lazy var buttonView: UIButton = {
            let button = UIButton()
            button.setTitle(self.title, for: .normal)
            button.setImage(self.image, for: .normal)
            button.contentVerticalAlignment = .center
//            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
            button.theme = self.theme
            if let action = self.actionBlock {
                button.addTapActionBlock(action)
            }
            return button
        }()

        static func == (lhs: SegmentData, rhs: SegmentData) -> Bool {
            lhs.title == rhs.title && lhs.image == rhs.image && lhs.theme == rhs.theme
        }
    }
}
