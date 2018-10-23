//
//  NRSearchFilterViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRSearchFilterViewController: NRBaseCollectionViewController {

    // View Model
    lazy var viewModel = {
        return NRSearchFilterViewModel(delegate: self, modelStack: self.modelStack as? NRSearchFilterModel)
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupColletionView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // update-filter-details
        viewModel.updateSearchFilter()
    }

    // MARK: setupColletionView
    func setupColletionView() {

        // Register Cell
        collectionView.register(NRSelectionCollectionViewCell.getNIBFile(),
                                forCellWithReuseIdentifier: kSearchFilterCellIdentifier)
    }

}

extension NRSearchFilterViewController: NRSearchFilterViewModelProtocal {

    func refreshCollectionView() {
        self.configureColletionView()
    }

}

extension NRSearchFilterViewController: UICollectionViewDelegateFlowLayout {

    // numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sectionItems.count
    }

    // cellForItem
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSearchFilterCellIdentifier, for: indexPath)

        let filterItem = viewModel.sectionItems[indexPath.section]
        let cur = filterItem.content[indexPath.row]
        if  !cur.data.isNilOrEmpty {
            if let cell = cell as? NRConfigureNovelCellProtocol {
                cell.configureContent(content: cur)
            }
        }

        return cell
    }

//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cur = viewModel.currentNovelList?[indexPath.row]
//        self.performSegue(withIdentifier: "kShowNovelChapterList", sender: cur)
//    }

}
