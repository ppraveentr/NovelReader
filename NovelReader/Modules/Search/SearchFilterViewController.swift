//
//  SearchFilterViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class SearchFilterViewController: UIViewController, CollectionViewControllerProtocol {

    // View Model
    lazy var viewModel = {
        SearchFilterViewModel(delegate: self, modelStack: self.modelStack as? SearchFilterModel)
    }()

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupColletionView()
        
        // update-filter-details
        viewModel.updateSearchFilter()
    }

    public override var flowLayout: UICollectionViewLayout {
        let layout = super.flowLayout
        (layout as? UICollectionViewFlowLayout)?.sectionHeadersPinToVisibleBounds = false
        return layout
    }

    // MARK: setupColletionView
    func setupColletionView() {

        // Register Cell
        SelectionCollectionViewCell.registerNib(for: collectionView)

        // Collection Header: Segment Control
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "headerCell"
        )
    }

    @IBAction
    private func resetSelection(_ sender: Any) {
        viewModel.resetSelection()
    }
}

extension SearchFilterViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

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

        if let headerView = headerView as? SectionHeaderView {
            headerView.setSectionHeader(title: viewModel.sectionTitleAt(indexPath), image: nil)
            headerView.setRightButton(title: nil, image: #imageLiteral(resourceName: "close-circle")) { [weak self] in
                self?.viewModel.resetSelection(indexPath)
            }
        }
        
        return headerView
    }

    // cellForItem
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = try? SelectionCollectionViewCell.dequeue(from: collectionView, for: indexPath) else {
            return UICollectionViewCell()
        }

        // CheckMark
        cell.isSelected = viewModel.isSelected(indexPath).found

        // Config content
        if
            let cell = cell as? ConfigureNovelCellProtocol,
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

extension SearchFilterViewController: SearchFilterViewModelProtocal {
    func refreshCollectionView() {
        self.configureColletionView()
    }
}
