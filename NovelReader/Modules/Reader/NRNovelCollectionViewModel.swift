//
//  NRNovelCollectionViewModel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 02/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

typealias NRNovelCollectionLifeCycleDelegate = (FTBaseViewController & NRNovelCollectionViewModelProtocal & UICollectionViewDelegate & UICollectionViewDataSource)

protocol NRNovelCollectionViewModelProtocal {
    func showRetryAlert()
    func configureColletionView(_ delegate: UICollectionViewDelegate?, _ source: UICollectionViewDataSource?)
}

class NRNovelCollectionViewModel {

    weak var lifeDelegate: NRNovelCollectionLifeCycleDelegate?
    var modelStack: FTServiceModel?

    init(delegate: NRNovelCollectionLifeCycleDelegate, modelStack: FTServiceModel?) {
        self.lifeDelegate = delegate
        self.modelStack = modelStack
    }

    lazy var novel: NRNovels? = NRNovels()

    // Update collectionView when contentList changes
    var currentNovelList: [NRNovel]? = [] {
        didSet {
            lifeDelegate?.configureColletionView(self.lifeDelegate, self.lifeDelegate)
        }
    }

    // Collection Content Type
    var novelCollectionType: NRNovelCollectionType = .recentNovel {
        didSet {
            self.fetchNovelList()
        }
    }

    func fetchNovelList() {

        switch novelCollectionType {
        case .recentNovel:
            NRServiceProvider.fetchRecentUpdateList { [weak self] novelList in
                if let novelList = novelList {
                    self?.currentNovelList = novelList
                }
                else {
                    self?.lifeDelegate?.showRetryAlert()
                }
            }
        case .topNovel:
            NRServiceProvider.fetchNovelList(novel: self.novel) { [weak self] novelList in
                self?.currentNovelList = self?.novel?.novelList
            }
        }
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
            collectionView.register(
                NRRecentNovelCollectionViewCell.getNIBFile(),
                forCellWithReuseIdentifier: self.cellIdentifier
            )
        case .topNovel:
            collectionView.register(
                NRNovelCollectionViewCell.getNIBFile(),
                forCellWithReuseIdentifier: self.cellIdentifier
            )
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
