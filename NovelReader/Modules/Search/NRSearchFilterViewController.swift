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
        NRSearchFilterViewModel(delegate: self, modelStack: self.modelStack as? NRSearchFilterModel)
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupColletionView()
        
        // update-filter-details
        viewModel.updateSearchFilter()
    }

    override var flowLayout: NSObject {
        let layout = super.flowLayout
        (layout as? UICollectionViewFlowLayout)?.sectionHeadersPinToVisibleBounds = false
        return layout
    }

    // MARK: setupColletionView
    func setupColletionView() {

        // Register Cell
        collectionView.register(
            NRSelectionCollectionViewCell.nib,
            forCellWithReuseIdentifier: kSearchFilterCellIdentifier
        )

        // Collection Header: Segment Control
        collectionView.register(
            NRSectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "headerCell"
        )
    }

    @IBAction
    private func resetSelection(_ sender: Any) {
        viewModel.resetSelection()
    }
}

extension NRSearchFilterViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }

    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }

    // viewForSupplementaryElement
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "headerCell",
            for: indexPath
        )

        if let headerView = headerView as? NRSectionHeaderView {
            headerView.setSectionHeader(title: viewModel.sectionTitleAt(indexPath), image: nil)
            headerView.setRightButton(title: nil, image: #imageLiteral(resourceName: "close-circle")) { [weak self] _, _ in
                self?.viewModel.resetSelection(indexPath)
            }
        }
        
        return headerView
    }

    // cellForItem
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kSearchFilterCellIdentifier, for: indexPath)

        // CheckMark
        cell.isSelected = viewModel.isSelected(indexPath).found

        // Config content
        if
            let cell = cell as? NRConfigureNovelCellProtocol,
            let cur = viewModel.cellForItemAt(indexPath) {
            cell.configureContent(content: cur)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        // Update User selection
        viewModel.updateSelection(indexPath)
    }
}

extension NRSearchFilterViewController: NRSearchFilterViewModelProtocol {
    func refreshCollectionView() {
        self.configureColletionView()
    }
}
