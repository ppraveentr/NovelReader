//
//  NRSearchCollectionViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRSearchCollectionViewController: NRBaseCollectionViewController {

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
    
    // MARK: configureColletionView
    override func configureColletionView() {
        super.configureColletionView()

        // Register Cell
        collectionView.register(NRNovelCollectionViewCell.getNIBFile(),
                                forCellWithReuseIdentifier: kNovelCellIdentifier)
    }
    
}

extension NRSearchCollectionViewController: UICollectionViewDelegateFlowLayout {

    // numberOfItemsInSection
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentNovelList?.count ?? 0
    }

    // cellForItem
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNovelCellIdentifier, for: indexPath)

        if let cur = currentNovelList?[indexPath.row] {
            if let cell = cell as? NRConfigureNovelCellProtocol {
                cell.configureContent(novel: cur, view: collectionView, indexPath: indexPath)
            }
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cur = currentNovelList?[indexPath.row]
        self.performSegue(withIdentifier: "kShowNovelChapterList", sender: cur)
    }
    
}
