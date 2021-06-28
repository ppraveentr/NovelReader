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

    var headerView: SegmentCollectionHeaderView?
    
    // View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true        
        // Novel Segment type
        viewModel.novelCollectionType = .recentNovel
        // View Title
        let rightButtonItem = UIBarButtonItem(itemType: .search)
        self.setupNavigationbar(title: Constants.novelReaderTitle, rightButton: rightButtonItem)
        // Collection View
        setupColletionView()
    }

    // MARK: SetUp UICollectionView
    func setupColletionView() {
        // Register Cell
        NovelCollectionType.registerCell(collectionView)

        // Collection Header: Segment Control
        let kind = UICollectionView.elementKindSectionHeader
        SegmentCollectionHeaderView.registerClass(for: collectionView, forSupplementaryViewOfKind: kind)
    }

    // Navigation bar Button action
    override func rightButtonAction() {
        performSegue(withIdentifier: Storyboard.searchStoryboardID, sender: nil)
    }
}

// MARK: Fetch - Novels from backend
extension NovelCollectionViewController: NovelCollectionViewModelProtocal {
    
    func showRetryAlert() {
        let alert = UIAlertController(title: Constants.serviceFailureAlertTitle,
                                      message: Constants.serviceFailureAlertMessage,
                                      preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: Constants.retryString, style: .default) { [weak self] _ in
            self?.viewModel.fetchNovelList()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    // Updates novelCollectionType, which interns fetchNovelList from backend
    func updateNovelSegment(_ index: Int) {
        viewModel.novelCollectionType = NovelCollectionType(rawValue: index) ?? .recentNovel
    }
}

// MARK: UICollectionView delegates
extension NovelCollectionViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate,
                                         UICollectionViewDataSource, StoryboardSegueProtocol {
    // viewForSupplementaryElement
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView: SegmentCollectionHeaderView = try? .dequeue(from: collectionView, ofKind: kind,
                                                                          for: indexPath) else {
            return UICollectionReusableView()
        }
        self.headerView = headerView
        headerView.segmentedControl.handler = { [weak self] index in
            self?.updateNovelSegment(index)
        }
        return headerView
    }

    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.currentNovelList?.count ?? 0
    }

    // cellForItem
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = viewModel.novelCollectionType.cellType
        guard let cell = try? cellType.dequeue(from: collectionView, for: indexPath) else {
            return UICollectionViewCell()
        }
        // update cell content
        if let model = viewModel.currentNovelList?[indexPath.row] {
            (cell as? ConfigureNovelCellProtocol)?.configureContent(content: model, view: collectionView,
                                                                    indexPath: indexPath)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = self.headerView?.preferredLayoutAttributesFitting(.init()).frame.height ?? 50
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = viewModel.currentNovelList?[indexPath.row] else { return }
        let segue = viewModel.novelCollectionType == .recentNovel ?
            Storyboard.Segue.showNovelReaderView : Storyboard.Segue.showNovelChapterList
        self.performSegue(withIdentifier: segue, sender: model)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        configure(segue: segue, sender: sender)
    }
}
