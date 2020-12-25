//
//  SearchCollectionViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class SearchCollectionViewController: UIViewController, CollectionViewControllerProtocol,
                                      SearchCollectionViewModelProtocal {

    // View Model
    lazy var viewModel = {
        SearchCollectionViewModel(delegate: self, modelStack: self.modelStack as? ServiceModel)
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupColletionView()
    }
    
    // MARK: setupColletionView
    func setupColletionView() {
        // Register Cell
        NovelCollectionViewCell.registerNib(for: collectionView)
        // Collection Header: Segment Control
        self.topPinnedView = SearchBarHeaderView(delegate: self)
        refreshCollectionView()
    }
    
    func refreshCollectionView() {
    }
}

extension SearchCollectionViewController: UISearchBarDelegate {

    // Dismiss keyboard on tap of search. Will invoke `searchBarTextDidEndEditing`
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        endEditing()
    }

    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            viewModel.searchNovel(keywoard: searchText)
        }
    }
}

extension SearchCollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.currentNovelList?.count ?? 0
    }

    // cellForItem
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = try? NovelCollectionViewCell.dequeue(from: collectionView, for: indexPath),
            let novel = viewModel.currentNovelList?[indexPath.row]
            else {
            return UICollectionViewCell()
        }

       if let cell = cell as? ConfigureNovelCellProtocol {
            cell.configureContent(content: novel, indexPath: indexPath)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cur = viewModel.currentNovelList?[indexPath.row]
        self.performSegue(withIdentifier: Storyboard.Segue.showNovelDetailsView, sender: cur)
    }
}
