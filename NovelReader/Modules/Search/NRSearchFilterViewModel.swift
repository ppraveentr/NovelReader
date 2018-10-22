//
//  NRSearchFilterViewModel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 22/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

typealias NRSearchFilterCollectionLifeCycleDelegate = (FTBaseViewController & NRSearchFilterViewModelProtocal)

protocol NRSearchFilterViewModelProtocal {
    func refreshCollectionView()
}

class NRSearchFilterViewModel {

    weak var lifeDelegate: NRSearchFilterCollectionLifeCycleDelegate?
    var modelStack: NRSearchFilterModel? = nil {
        didSet {
            lifeDelegate?.refreshCollectionView()
        }
    }

    init(delegate: NRSearchFilterCollectionLifeCycleDelegate, modelStack: NRSearchFilterModel? = nil) {
        self.lifeDelegate = delegate
        self.modelStack = modelStack
    }

    // get-filter from backend
    func updateSearchFilter() {
        NRServiceProvider.searchFilter { [weak self] (filter) in
            print(filter ?? "")
            self?.modelStack = filter
        }
    }

}
