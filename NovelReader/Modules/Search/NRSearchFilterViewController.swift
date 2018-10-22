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
        collectionView.register(NRNovelCollectionViewCell.getNIBFile(),
                                forCellWithReuseIdentifier: kNovelCellIdentifier)
        
    }

}

extension NRSearchFilterViewController: NRSearchFilterViewModelProtocal {

    func refreshCollectionView() {
        self.configureColletionView()
    }

}
