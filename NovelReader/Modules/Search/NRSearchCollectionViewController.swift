//
//  NRSearchCollectionViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRSearchCollectionViewController: NRBaseCollectionViewController {

    // View Model
    lazy var viewModel = {
        return NRSearchCollectionViewModel(delegate: self, modelStack: self.modelStack as? FTServiceModel)
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupColletionView()
    }
    
    // MARK: setupColletionView
    func setupColletionView() {

        // Register Cell
        collectionView.register(NRNovelCollectionViewCell.getNIBFile(),
                                forCellWithReuseIdentifier: kNovelCellIdentifier)

        // Collection Header: Segment Control
        self.baseView?.topPinnedView = NRSearchBarHeaderView(delegate: self)
    }
    
}

extension NRSearchCollectionViewController: NRSearchCollectionViewModelProtocal {

    func refreshCollectionView() {
        self.configureColletionView()
    }

}

extension NRSearchCollectionViewController: UISearchBarDelegate {

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

extension NRSearchCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentNovelList?.count ?? 0
    }

    // cellForItem
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNovelCellIdentifier, for: indexPath)

        if let cur = viewModel.currentNovelList?[indexPath.row] {
            if let cell = cell as? NRConfigureNovelCellProtocol {
                cell.configureContent(content: cur, view: collectionView, indexPath: indexPath)
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cur = viewModel.currentNovelList?[indexPath.row]
        self.performSegue(withIdentifier: "kShowNovelChapterList", sender: cur)
    }
    
}
