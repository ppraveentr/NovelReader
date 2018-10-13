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
}

class NRSearchCollectionViewModel {

    weak var lifeDelegate: NRSearchCollectionLifeCycleDelegate?
    var modelStack: FTServiceModel? = nil

    init(delegate: NRSearchCollectionLifeCycleDelegate, modelStack: FTServiceModel? = nil) {
        self.lifeDelegate = delegate
        self.modelStack = modelStack
    }
}
