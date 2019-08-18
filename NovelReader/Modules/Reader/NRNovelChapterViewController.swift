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
    
    override func tableStyle() -> UITableView.Style { return .grouped }
//    override func tableViewEdgeOffsets() -> FTEdgeOffsets { return FTEdgeOffsets(10, 0, 10, 0) }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolBar()
        tableView.backgroundColor = .clear
        tableView.register(NRNovelTableViewCell.getNIBFile(), forCellReuseIdentifier: kNovelCellIdentifier)
        
        NRServiceProvider.getNovelChaptersList(novel.forceUnwrapped) { [weak self] novelResponse in
            guard novelResponse != nil, let self = self else {
                return
            }
            if let novelResponse = novelResponse {
                self.novel?.merge(data: novelResponse)
            }
            self.configureContent(content: self.novel.forceUnwrapped)
        }
    }
    
    func configureContent(content: AnyObject) {
        if let content = content as? NRNovel {
            self.novelDescView?.configureContent(content: content)
            self.tableView.setTableHeaderView(view: self.novelDescView)
            self.tableView.reloadData()
        }
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
            cell.configureContent(content: cur)
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
//        searchBar.placeholder = "Search"
//        searchBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.navigationItem.titleView = searchBar

        self.setupNavigationbar(
            title: "",
            leftButton: self.navigationBarButton(buttonType: .stop),
            rightButton: self.navigationBarButton(buttonType: .bookmarks)
        )
    }
    
    //     func setupToolBar() {
    // 
    //         let refresh = UIRefreshControl()
    //         refresh.addTarget(self, action: #selector(setupSearchBar), for: .valueChanged)
    //         self.tableView.addSubview(refresh)
    //         self.tableViewController.refreshControl = refresh
    //     }
    
}
