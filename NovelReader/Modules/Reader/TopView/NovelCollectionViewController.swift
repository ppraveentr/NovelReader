//
//  NovelCollectionViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 21/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

final class NovelCollectionViewController: UIViewController, CollectionViewControllerProtocol {

    // View Model
    lazy var viewModel = {
        NovelCollectionViewModel(delegate: self, modelStack: self.modelStack as? ServiceModel)
    }()

    // View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Novel Segment type
        viewModel.novelCollectionType = .recentNovel
        // View Title
        let rightButtonItem = UIBarButtonItem(itemType: .search)
        self.setupNavigationbar(title: kNovelReaderTitle, rightButton: rightButtonItem)
        // Collection View
        setupColletionView()
    }

    // MARK: SetUp UICollectionView
    func setupColletionView() {
        // Register Cell
        NovelCollectionType.registerCell(collectionView)

        // Collection Header: Segment Control
        SegmentCollectionHeaderView.registerClass(for: collectionView,
                                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
    }

    // Navigation bar Button action
    override func rightButtonAction() {
        performSegue(withIdentifier: kSearchStoryboardID, sender: nil)
    }
}

// MARK: Fetch - Novels from backend
extension NovelCollectionViewController: NovelCollectionViewModelProtocal {
    
    func showRetryAlert() {
        let alert = UIAlertController(title: kServiceFailureAlertTitle, message: kServiceFailureAlertMessage, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: kRetryString, style: .default) { [weak self] _ in
            self?.viewModel.fetchNovelList()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    // Updates novelCollectionType, which interns fetchNovelList from backend
    func updateNovelSegment(segmentControl: UISegmentedControl) {
        viewModel.novelCollectionType = NovelCollectionType(rawValue: segmentControl.selectedSegmentIndex) ?? .recentNovel
    }
}

// MARK: UICollectionView delegates
extension NovelCollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    // viewForSupplementaryElement
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView: SegmentCollectionHeaderView = try? .dequeue(from: collectionView, ofKind: kind, for: indexPath) else {
            return UICollectionReusableView()
        }
        headerView.segmentedControl?.handler = { [weak self] _ in
            if let segment = headerView.segmentedControl {
                self?.updateNovelSegment(segmentControl: segment)
            }
        }
        return headerView
    }

    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentNovelList?.count ?? 0
    }

    // cellForItem
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = viewModel.novelCollectionType.cellType
        guard let cell = try? cellType.dequeue(from: collectionView, for: indexPath) else {
            return UICollectionViewCell()
        }
        // update cell content
        if let model = viewModel.currentNovelList?[indexPath.row] {
            (cell as? ConfigureNovelCellProtocol)?.configureContent(content: model, view: collectionView, indexPath: indexPath)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = viewModel.currentNovelList?[indexPath.row] else { return }
        if viewModel.novelCollectionType == .recentNovel {
            self.performSegue(withIdentifier: kShowNovelReaderView, sender: model)
        }
        else {
            self.performSegue(withIdentifier: kShowNovelChapterList, sender: model)
        }
    }
}
