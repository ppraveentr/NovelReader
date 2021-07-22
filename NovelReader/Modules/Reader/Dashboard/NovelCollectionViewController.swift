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
    lazy var manager = DataSourceManager(collectionDelegate: self)

    // View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Novel Segment type
        viewModel.novelCollectionType = .recentNovel
        // View Title
        setupNavigationBar()
        // Collection View
        setupColletionView()
    }

    // MARK: Setup CollectionView
    func setupColletionView() {
        // Register Cell
        NovelCollectionType.registerCell(manager)
        // Collection Header: Segment Control
        manager.register(SegmentCollectionHeaderView.self, kind: UICollectionView.elementKindSectionHeader)
        manager.layoutReferenceSize = { _ -> UICollectionReusableView? in
            self.headerView
        }
        manager.dequeueReusableView = { indexPath, _ -> DataSourceManager.DequeueReusableViewReturn in
            let block: ActionWithObjectBlock = { obj in
                guard let headerView = obj as? SegmentCollectionHeaderView else { return }
                headerView.segmentedControl.handler = { [weak self] index in
                    self?.updateNovelSegment(index)
                }
                self.headerView = headerView
            }
            return (SegmentCollectionHeaderView.self, block)
        }
        // Collection View Cell
        manager.dequeueView = { indexPath -> UICollectionViewCell.Type in
            self.viewModel.novelCollectionType.cellType
        }
        manager.configureDidSelect = { _, obj in
            let segue = self.viewModel.novelCollectionType == .recentNovel ?
                Storyboard.Segue.showNovelReaderView : Storyboard.Segue.showNovelChapterList
            self.performSegue(withIdentifier: segue, sender: obj)
        }
    }

    // Navigation bar Button action
    override func rightButtonAction() {
        performSegue(withIdentifier: Storyboard.searchStoryboardID, sender: nil)
    }
}

// MARK: Fetch - Novels from backend
extension NovelCollectionViewController: NovelCollectionViewModelProtocal {
    func reloadCellObjects() {
        manager.removeAllObjects()
        guard let objects = viewModel.currentNovelList else { return }
        manager.updateCellObjects([objects])
    }
    
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

// MARK: StoryboardSegueProtocol
extension NovelCollectionViewController: StoryboardSegueProtocol {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        configure(segue: segue, sender: sender)
    }
    
    func setupNavigationBar() {
        // View Title
        let rightButtonItem = UIBarButtonItem(itemType: .search)
        self.setupNavigationbar(title: Constants.novelReaderTitle, rightButton: rightButtonItem)
        // Hide Navigation bar on Scroll
        self.hideNavigationOnScroll(for: collectionView)
        self.view.theme = ThemeStyle.defaultStyle
    }
}
