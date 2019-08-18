//
//  NRNovelCollectionViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 21/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRNovelCollectionViewController: NRBaseCollectionViewController {

    // View Model
    lazy var viewModel = {
        return NRNovelCollectionViewModel(delegate: self, modelStack: self.modelStack as? FTServiceModel)
    }()

    // View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Novel Segment type
        viewModel.novelCollectionType = .recentNovel

        // View Title
        //self.setupNavigationbar(title: kNovelReaderTitle, leftCustomView: NRGoogleAuth.signInButton())
        rightNavigationBarButton(buttonType: .search)

        // Collection View
        setupColletionView()
    }

    // MARK: SetUp UICollectionView
    func setupColletionView() {
        
        // Register Cell
        NRNovelCollectionType.topNovel.registerCell(collectionView)
        NRNovelCollectionType.recentNovel.registerCell(collectionView)

        // Collection Header: Segment Control
        collectionView.register(NRSegmentCollectionHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "headerCell")
    }

    // Navigation bar Button action
    override func rightButtonAction() {
        performSegue(withIdentifier: kSearchStoryboardID, sender: nil)
    }
    
}

// MARK: Fetch - Novels from backend
extension NRNovelCollectionViewController: NRNovelCollectionViewModelProtocal {

    func showRetryAlert() {
        let alert = UIAlertController(title: kServiceFailureAlertTitle, message: kServiceFailureAlertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: kRetryString, style: .default, handler: { [weak self] action in
            self?.viewModel.fetchNovelList()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    // Updates novelCollectionType, which interns fetchNovelList from backend
    func updateNovelSegment(segmentControl: UISegmentedControl) {
        viewModel.novelCollectionType = NRNovelCollectionType(rawValue: segmentControl.selectedSegmentIndex)!
    }

}

// MARK: UICollectionView delegates
extension NRNovelCollectionViewController: UICollectionViewDelegateFlowLayout {

    // viewForSupplementaryElement
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell", for: indexPath) as! NRSegmentCollectionHeaderView

        headerView.segmentedControl?.handler = { [unowned self] (sender) in
            if let segment = headerView.segmentedControl {
                self.updateNovelSegment(segmentControl: segment)
            }
        }

        return headerView
    }

    // numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentNovelList?.count ?? 0
    }

    // cellForItem
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cellIdentifier =  viewModel.novelCollectionType.cellIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)

        if let cur = viewModel.currentNovelList?[indexPath.row] {
            if let cell = cell as? NRConfigureNovelCellProtocol {
                cell.configureContent(content: cur, view: collectionView, indexPath: indexPath)
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cur = viewModel.currentNovelList?[indexPath.row]

        if viewModel.novelCollectionType == .recentNovel {
            self.performSegue(withIdentifier: kShowNovelReaderView, sender: cur)
        } else {
            self.performSegue(withIdentifier: kShowNovelChapterList, sender: cur)
        }
    }
    
}
