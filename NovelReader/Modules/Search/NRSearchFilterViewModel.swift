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

enum NRSearchFilterType {
    case novelType, genres, language, completed
}

struct NRSearchFilterCellContent {
    var type: NRSearchFilterType
    var content: [NRFilterModel]
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

    var sectionItems: [NRSearchFilterCellContent] {
        var items = [NRSearchFilterCellContent]()

        if  let type = modelStack?.novelType, type.count > 0 {
            let item = NRSearchFilterCellContent(type: .novelType, content: type)
            items.append(item)
        }
        if  let type = modelStack?.genres, type.count > 0 {
            let item = NRSearchFilterCellContent(type: .genres, content: type)
            items.append(item)
        }
        if  let type = modelStack?.language, type.count > 0 {
            let item = NRSearchFilterCellContent(type: .language, content: type)
            items.append(item)
        }
        if  let type = modelStack?.completed, type.count > 0 {
            let item = NRSearchFilterCellContent(type: .completed, content: type)
            items.append(item)
        }

        return items
    }

}
