//
//  FirstViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import UIKit

class NRNovelChapterViewController: NRBaseTableViewController {

    var novel: NRNovel?
    
    lazy var novelDescView: NRNovelDescriptionView? = NRNovelDescriptionView.fromNib() as? NRNovelDescriptionView
    
    override func class_TableViewStyle() -> UITableView.Style { return .grouped }
    override func class_TableViewEdgeOffsets() -> FTEdgeOffsets { return FTEdgeOffsets(10, 0, 10, 0) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolBar()
        tableView.backgroundColor = .clear
        tableView.register(NRNovelTableViewCell.getNIBFile(), forCellReuseIdentifier: kNovelCellIdentifier)
        
        NRServiceProvider.getNovelChaptersList(novel!, completionHandler: { (novelResponse: NRNovel?) in
            guard (novelResponse != nil) else { return }
            self.novel?.merge(data: novelResponse!)
            self.configureContent(novel: self.novel!)
        })
    }
    
    func configureContent(novel: NRNovel) {
        self.novelDescView?.configureContent(novel: self.novel!)
        self.tableView.setTableHeaderView(view: self.novelDescView)
        self.tableView.reloadData()
    }
}

extension NRNovelChapterViewController {
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return novel?.chapterList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kNovelCellIdentifier, for: indexPath)
        
        if
            let cell = cell as? NRNovelTableViewCell,
            let cur = novel?.chapterList?[indexPath.row] {
            cell.configureContent(novel: cur)
        }
        
        return cell
    }
}

extension NRNovelChapterViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cur = novel?.chapterList?[indexPath.row] {
            self.performSegue(withIdentifier: kShowNovelReaderView, sender: cur)
        }
    }
    
}

extension NRNovelChapterViewController {
    
    func setupToolBar() {

//        let searchBar = FTSearchBar(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 44)), textColor: .white)
//        searchBar.configure(barTintColor: "#de6161".hexColor()!, tintColor: .white)
//        searchBar.placeholder = "Search"
//        searchBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        self.navigationItem.titleView = searchBar

        self.setupNavigationbar(title: "",
                                leftButton: self.navigationBarButton(buttonType: .stop),
                                rightButton: self.navigationBarButton(buttonType: .bookmarks))
    }
    
    //    func setupToolBar() {
    //
    //        let refresh = UIRefreshControl()
    //        refresh.addTarget(self, action: #selector(setupSearchBar), for: .valueChanged)
    //        self.tableView.addSubview(refresh)
    //        self.tableViewController.refreshControl = refresh
    //    }
}
