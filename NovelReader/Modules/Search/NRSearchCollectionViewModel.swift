//
//  NRSearchCollectionViewModel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

typealias NRSearchCollectionLifeCycleDelegate = (FTBaseViewController & NRSearchCollectionViewModelProtocal)

protocol NRSearchCollectionViewModelProtocal {
    func refreshCollectionView()
}

class NRSearchCollectionViewModel {

    weak var lifeDelegate: NRSearchCollectionLifeCycleDelegate?
    var modelStack: FTServiceModel?

    init(delegate: NRSearchCollectionLifeCycleDelegate, modelStack: FTServiceModel? = nil) {
        self.lifeDelegate = delegate
        self.modelStack = modelStack
    }

    // Update collectionView when contentList changes
    var currentNovelList: [NRNovel]? = [] {
        didSet {
            lifeDelegate?.refreshCollectionView()
        }
    }

    // get-Novels from backend
    func searchNovel(keywoard: String) {
        guard keywoard.count > 0 else {
            return
        }

        NRServiceProvider.searchNovel(keyword: keywoard) { novelList in
            self.currentNovelList = novelList
        }
    }
}
