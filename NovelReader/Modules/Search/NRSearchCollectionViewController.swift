//
//  NRSearchCollectionViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRSearchCollectionViewController: NRBaseViewController {

    lazy var collectionView: UICollectionView = self.getCollectionView()
    // Update collectionView when contentList changes
    var currentNovelList: [NRNovel]? = [] {
        didSet {
            self.configureColletionView()
        }
    }

    // Dummycell for collectionView cell Height calculation
    var dummyNovelCell: NRConfigureNovelCellProtocol = NRNovelCollectionViewCell.fromNib() as! NRNovelCollectionViewCell

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolBar()
        self.searchNovelList()
    }

    // get-Novels from backend
    func searchNovelList() {
        NRServiceProvider.fetchNovelList(novel: nil) { (novelList) in
            self.currentNovelList = novelList?.novelList
        }
    }

    func setupToolBar() {

        let searchBar = FTSearchBar(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 44)), textColor: .white)
        searchBar.configure(barTintColor: "#de6161".hexColor()!, tintColor: .white)
        searchBar.placeholder = "Search"
        searchBar.autoresizingMask = [.flexibleRightMargin, .flexibleHeight]

        self.navigationItem.titleView = searchBar

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: NRGoogleAuth.signInButton())

    }
}

extension NRSearchCollectionViewController {

    func getCollectionView() -> UICollectionView {
        let flow = self.getflowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collectionView.backgroundView?.backgroundColor = .clear
        return collectionView
    }

    func getflowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width:0, height:45)
        layout.footerReferenceSize = .zero
        layout.sectionInset = UIEdgeInsets(top: 15, left: 20, bottom: 10, right: 20)
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }

    func configureColletionView() {

        // Relaod collectionView on exit
        defer {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        // Only re-load collectionView if already present
        guard collectionView.superview == nil else {
            return
        }

        // Setup collectionView, if not added in view.

        // Register Cell
        collectionView.register(NRNovelCollectionViewCell.getNIBFile(),
                                forCellWithReuseIdentifier: kNovelCellIdentifier)

        // CollectionView delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear

        self.mainView?.pin(view: collectionView)
    }
}

extension NRSearchCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {

    // numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentNovelList?.count ?? 0
    }

    // cellForItem
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNovelCellIdentifier, for: indexPath)

        if let cur = currentNovelList?[indexPath.row] {
            if let cell = cell as? NRConfigureNovelCellProtocol {
                cell.configureContent(novel: cur, view: collectionView, indexPath: indexPath)
            }
        }

        return cell
    }

    // Cell sizeForItem
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let cell = self.dummyNovelCell

        if let cur = currentNovelList?[indexPath.row] {
            cell.configureContent(novel: cur, view: collectionView, indexPath: indexPath)
        }

        return cell.getSize(baseView: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cur = currentNovelList?[indexPath.row]
        self.performSegue(withIdentifier: "kShowNovelChapterList", sender: cur)
    }
}
