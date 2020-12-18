//
//  SearchCollectionViewModel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

typealias NRSearchCollectionLifeCycleDelegate = (ViewControllerProtocol & SearchCollectionViewModelProtocal)

protocol SearchCollectionViewModelProtocal {
    func refreshCollectionView()
}

class SearchCollectionViewModel {

    weak var lifeDelegate: NRSearchCollectionLifeCycleDelegate?
    var modelStack: ServiceModel?

    init(delegate: NRSearchCollectionLifeCycleDelegate, modelStack: ServiceModel? = nil) {
        self.lifeDelegate = delegate
        self.modelStack = modelStack
    }

    // Update collectionView when contentList changes
    var currentNovelList: [NovelModel]? = [] {
        didSet {
            lifeDelegate?.refreshCollectionView()
        }
    }

    // get-Novels from backend
    func searchNovel(keywoard: String) {
        guard keywoard.count > 0 else { return }

        NovelServiceProvider.searchNovel(keyword: keywoard) { novelList in
            self.currentNovelList = novelList
        }
    }
}
