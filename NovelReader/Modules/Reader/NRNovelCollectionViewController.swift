//
//  NRNovelCollectionViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 21/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRNovelCollectionViewController: NRBaseCollectionViewController {

    // Collection Content Type
    var novelCollectionType: NRNovelCollectionType = .recentNovel {
        didSet {
            self.fetchNovelList()
        }
    }

    lazy var novel: NRNovels? = NRNovels()
    // Update collectionView when contentList changes
    var currentNovelList: [NRNovel]? = [] {
        didSet {
            self.setupColletionView()
        }
    }

    // View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.novelCollectionType = .recentNovel
        self.setupNavigationbar(title: kNovelReaderTitle, leftCustomView: NRGoogleAuth.signInButton())
        rightNavigationBarButton(buttonType: .search)

        configureColletionView()
    }

    // Updates novelCollectionType, which interns fetchNovelList from backend
    func updateNovelSegment(segmentControl: FTSegmentedControl) {
        novelCollectionType = NRNovelCollectionType(rawValue: segmentControl.selectedSegmentIndex)!
    }

    // MARK: SetUp UICollectionView
    func configureColletionView() {
        
        // Register Cell
        NRNovelCollectionType.topNovel.registerCell(collectionView)
        NRNovelCollectionType.recentNovel.registerCell(collectionView)

        // Collection Header: Segment Control
        collectionView.register(NRNovelCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "headerCell")
    }

    // MARK: Dummycell for collectionView cell Height calculation
    lazy var sampleTopNovelCell = NRNovelCollectionType.topNovel.getNib()
    lazy var sampleRecentNovelCell = NRNovelCollectionType.recentNovel.getNib()
    var dummyNovelCell: NRConfigureNovelCellProtocol? {
        switch novelCollectionType {
        case .recentNovel:
            return self.sampleRecentNovelCell
        case .topNovel:
            return self.sampleTopNovelCell
        }
    }

    override func rightButtonAction() {
        performSegue(withIdentifier: kSearchStoryboardID, sender: nil)
    }
    
}

// MARK: Fetch - Novels from backend
extension NRNovelCollectionViewController {

    func fetchNovelList() {
        switch novelCollectionType {
        case .recentNovel:
            NRServiceProvider.fetchRecentUpdateList() { [weak self] (novelList) in
                if let novelList = novelList {
                    self?.currentNovelList = novelList
                } else {
                    self?.showRetryAlert()
                }
            }
        case .topNovel:
            NRServiceProvider.fetchNovelList(novel: self.novel) { [weak self] (novelList) in
                self?.currentNovelList = self?.novel?.novelList
            }
        }
    }

    func showRetryAlert() {
        let alert = UIAlertController(title: kServiceFailureAlertTitle, message: kServiceFailureAlertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: kRetryString, style: .default, handler: { [weak self] action in
            self?.fetchNovelList()
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

// MARK: UICollectionView delegates
extension NRNovelCollectionViewController: UICollectionViewDelegateFlowLayout {

    // viewForSupplementaryElement
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell", for: indexPath) as! NRNovelCollectionHeaderView

        headerView.segmentedControl?.handler = { [unowned self] (sender) in
            if let segment = headerView.segmentedControl {
                self.updateNovelSegment(segmentControl: segment)
            }
        }

        return headerView
    }

    // numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentNovelList?.count ?? 0
    }

    // cellForItem
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cellIdentifier = novelCollectionType.cellIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)

        if let cur = currentNovelList?[indexPath.row] {
            if let cell = cell as? NRConfigureNovelCellProtocol {
                cell.configureContent(novel: cur, view: collectionView, indexPath: indexPath)
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cur = currentNovelList?[indexPath.row]

        if novelCollectionType == .recentNovel {
            self.performSegue(withIdentifier: kShowNovelReaderView, sender: cur)
        } else {
            self.performSegue(withIdentifier: kShowNovelChapterList, sender: cur)
        }
    }
    
}

// MARK: NRNovelCollectionHeaderView
class NRNovelCollectionHeaderView: UICollectionReusableView {
    var segmentedControl: FTSegmentedControl? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSegmentView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setupSegmentView()
    }

    func setupSegmentView() {
        
        self.theme = ThemeStyle.defaultStyle

        segmentedControl = FTSegmentedControl(items: [ kRecentUpdateString, kTopViews ]) { (segment) in
            FTLog(segment)
        };

        self.pin(view: segmentedControl!, edgeOffsets: FTEdgeOffsets(10))
    }
    
}

// MARK: NRNovelCollectionType
enum NRNovelCollectionType: Int {
    case recentNovel = 0
    case topNovel

    var cellIdentifier: String {
        switch self {
        case .recentNovel:
            return kRecentNovelCellIdentifier
        case .topNovel:
            return kNovelCellIdentifier
        }
    }

    func registerCell(_ collectionView: UICollectionView) {
        switch self {
        case .recentNovel:
            collectionView.register(NRRecentNovelCollectionViewCell.getNIBFile(),
                                    forCellWithReuseIdentifier: self.cellIdentifier)
        case .topNovel:
            collectionView.register(NRNovelCollectionViewCell.getNIBFile(),
                                    forCellWithReuseIdentifier: self.cellIdentifier)
        }
    }

    func getNib() -> (UICollectionViewCell & NRConfigureNovelCellProtocol)? {
        switch self {
        case .recentNovel:
            return NRRecentNovelCollectionViewCell.fromNib() as? NRRecentNovelCollectionViewCell
        case .topNovel:
            return NRNovelCollectionViewCell.fromNib() as? NRNovelCollectionViewCell
        }
    }
    
}
