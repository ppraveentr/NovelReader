//
//  NovelCollectionViewModel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 02/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

typealias NovelCollectionLifeCycleDelegate = (ViewControllerProtocol & NovelCollectionViewModelProtocal)

protocol NovelCollectionViewModelProtocal {
    func showRetryAlert()
    func reloadCellObjects()
}

final class NovelCollectionViewModel {

    weak var lifeDelegate: NovelCollectionLifeCycleDelegate?
    var modelStack: ServiceModel?

    init(delegate: NovelCollectionLifeCycleDelegate, modelStack: ServiceModel?) {
        self.lifeDelegate = delegate
        self.modelStack = modelStack
    }

    lazy var novel: NovelListModel? = NovelListModel()

    // Update collectionView when contentList changes
    var currentNovelList: [NovelModel]? = [] {
        didSet {
            lifeDelegate?.reloadCellObjects()
        }
    }

    // Collection Content Type
    var novelCollectionType: NovelCollectionType = .recentNovel {
        didSet {
            self.fetchNovelList()
        }
    }

    func fetchNovelList() {
        switch novelCollectionType {
        case .recentNovel:
            NovelServiceProvider.fetchRecentUpdateList { [weak self] novelList in
                if let novelList = novelList {
                    self?.currentNovelList = novelList
                }
                else {
                    self?.lifeDelegate?.showRetryAlert()
                }
            }
        case .topNovel:
            NovelServiceProvider.fetchNovelList(novel: self.novel) { [weak self] novelList in
                self?.currentNovelList = self?.novel?.novelList
            }
        }
    }
}

// MARK: NovelCollectionType
enum NovelCollectionType: Int {
    case recentNovel = 0
    case topNovel

    var cellType: UICollectionViewCell.Type {
        switch self {
        case .recentNovel:
            return RecentNovelCollectionViewCell.self
        case .topNovel:
            return NovelCollectionViewCell.self
        }
    }

    static func registerCell(_ manager: DataSourceManager) {
        manager.register(RecentNovelCollectionViewCell.self)
        manager.register(NovelCollectionViewCell.self)
    }
}
