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

    // MARK: Collection Content
    var selectedIndexPath = [IndexPath]()

    // get-filter from backend
    func updateSearchFilter() {
        NRServiceProvider.searchFilter { [weak self] (filter) in
            print(filter ?? "")
            self?.modelStack = filter
        }
    }

}

// MARK: Search Filter Cell Content
enum NRSearchFilterType: String {
    case novelType, genres, language, completed

    var headerTitle: String {
        switch self {
        case .novelType:
            return "Novel Type:"
        case .genres:
            return "Genres:"
        case .language:
            return "Language:"
        case .completed:
            return "Completed:"
        }
    }
}

struct NRSearchFilterCellContent {
    var type: NRSearchFilterType
    var content: [NRFilterModel]
}

extension NRSearchFilterViewModel {

    // Cell Items
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

    // Collection cell
    var numberOfSections: Int {
        return sectionItems.count
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        return sectionItems[section].content.count
    }

    func sectionTitleAt(_ indexPath: IndexPath) -> String {
        return sectionItems[indexPath.section].type.headerTitle
    }

    func cellForItemAt(_ indexPath: IndexPath) -> NRFilterModel? {

        let filterItem = sectionItems[indexPath.section]
        let cur = filterItem.content[indexPath.row]
        if  !cur.data.isNilOrEmpty {
            return cur
        }
        return nil
    }

    // MARK: User Selection
    func isSelected(_ indexPath: IndexPath) -> (found: Bool, index: Int) {

        let indexArray = selectedIndexPath.filter { (index) -> Bool in
            return index == indexPath
        }

        if let filterIndex = indexArray.first, let index = selectedIndexPath.firstIndex(of: filterIndex) {
            return (true, index)
        }

        return (false, -1)
    }

    func updateSelection(_ indexPath: IndexPath) {
        let index = isSelected(indexPath)
        if index.found {
            selectedIndexPath.remove(at: index.index)
        } else {
            selectedIndexPath.append(indexPath)
        }

        lifeDelegate?.refreshCollectionView()
    }

    func resetSelection(_ indexPath: IndexPath? = nil) {
        selectedIndexPath.removeAll()
        lifeDelegate?.refreshCollectionView()
    }

}
