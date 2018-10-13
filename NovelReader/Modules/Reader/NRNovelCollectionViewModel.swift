//
//  NRNovelCollectionViewModel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 02/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

typealias NRNovelCollectionLifeCycleDelegate = (FTBaseViewController & NRNovelCollectionViewModelProtocal)

protocol NRNovelCollectionViewModelProtocal {
}

class NRNovelCollectionViewModel {

    weak var lifeDelegate: NRNovelCollectionLifeCycleDelegate?
    var modelStack: FTServiceModel? = nil

    init(delegate: NRNovelCollectionLifeCycleDelegate, modelStack: FTServiceModel? = nil) {
        self.lifeDelegate = delegate
        self.modelStack = modelStack
    }
}

