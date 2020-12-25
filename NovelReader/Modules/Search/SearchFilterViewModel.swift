//
//  SearchFilterViewModel.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 22/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

typealias SearchFilterLifeCycleDelegate = (ViewControllerProtocol & SearchFilterViewModelProtocal)

protocol SearchFilterViewModelProtocal {
    func refreshCollectionView()
}

class SearchFilterViewModel {

    weak var lifeDelegate: SearchFilterLifeCycleDelegate?
    var modelStack: SearchFilterModel? = nil {
        didSet {
            lifeDelegate?.refreshCollectionView()
        }
    }

    init(delegate: SearchFilterLifeCycleDelegate, modelStack: SearchFilterModel? = nil) {
        self.lifeDelegate = delegate
        self.modelStack = modelStack
    }

    // MARK: Collection Content
    var selectedIndexPath = [IndexPath]()

    // get-filter from backend
    func updateSearchFilter() {
        NovelServiceProvider.searchFilter { [weak self] filter in
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

struct SearchFilterCellContent {
    var type: NRSearchFilterType
    var contentArray: [FilterModel]
}

extension SearchFilterViewModel {

    // Cell Items
    var sectionItems: [SearchFilterCellContent] {
        var items = [SearchFilterCellContent]()

        if  let type = modelStack?.novelType, type.isEmpty {
            let item = SearchFilterCellContent(type: .novelType, contentArray: type)
            items.append(item)
        }
        if  let type = modelStack?.genres, type.isEmpty {
            let item = SearchFilterCellContent(type: .genres, contentArray: type)
            items.append(item)
        }
        if  let type = modelStack?.language, type.isEmpty {
            let item = SearchFilterCellContent(type: .language, contentArray: type)
            items.append(item)
        }
        if  let type = modelStack?.completed, type.isEmpty {
            let item = SearchFilterCellContent(type: .completed, contentArray: type)
            items.append(item)
        }

        return items
    }

    // Collection cell
    var numberOfSections: Int {
        return sectionItems.count
    }

    func numberOfItemsInSection(_ section: Int) -> Int {
        return sectionItems[section].contentArray.count
    }

    func sectionTitleAt(_ indexPath: IndexPath) -> String {
        return sectionItems[indexPath.section].type.headerTitle
    }

    func cellForItemAt(_ indexPath: IndexPath) -> FilterModel? {

        let filterItem = sectionItems[indexPath.section]
        let cur = filterItem.contentArray[indexPath.row]
        if  !cur.data.isNilOrEmpty {
            return cur
        }
        return nil
    }

    // MARK: User Selection
    func isSelected(_ indexPath: IndexPath) -> (found: Bool, index: Int) {

        let indexArray = selectedIndexPath.filter { index -> Bool in
            index == indexPath
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
        }
        else {
            selectedIndexPath.append(indexPath)
        }

        lifeDelegate?.refreshCollectionView()
    }

    func resetSelection(_ indexPath: IndexPath? = nil) {
        removeObjects(forSection: indexPath?.section)
        lifeDelegate?.refreshCollectionView()
    }
}

extension SearchFilterViewModel {
    
    func removeObjects(forSection section: Int?) {
        if let section = section {
            selectedIndexPath.removeAll { localIndex -> Bool in
                section == localIndex.section
            }
        }
        else {
            selectedIndexPath.removeAll()
        }
    }
}
