//
//  NovelChapterViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import UIKit

final class NovelChapterViewController: UIViewController, TableViewControllerProtocol {
    
    var novel: NovelModel?
    lazy var novelDescView: NovelDescriptionView? = NovelDescriptionView.fromNib() as? NovelDescriptionView
    
    func tableStyle() -> UITableView.Style { return .grouped }
//    override func tableViewEdgeOffsets() -> FTEdgeOffsets { return FTEdgeOffsets(10, 0, 10, 0) }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        guard let novel = novel else { return }
        NovelServiceProvider.getNovelChaptersList(novel) { [weak self] novelResponse in
            guard novelResponse != nil, let self = self else {
                return
            }
            if let novelResponse = novelResponse {
                self.novel?.merge(data: novelResponse)
            }
            self.configureContent(content: novel)
        }
    }
    
    func configureTableView() {
        setupToolBar()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        NovelTableViewCell.registerNib(for: tableView)
    }
    
    func configureContent(content: AnyObject) {
        if let content = content as? NovelModel {
            self.novelDescView?.configureContent(content: content)
            self.tableView.setTableHeaderView(view: self.novelDescView)
            self.tableView.reloadData()
        }
    }
}

extension NovelChapterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return novel?.chapterList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = try? NovelTableViewCell.dequeue(from: tableView, for: indexPath) else {
            return UITableViewCell()
        }
        
        if
            let cell = cell as? NovelTableViewCell,
            let cur = novel?.chapterList?[indexPath.row] {
            cell.configureContent(content: cur)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cur = novel?.chapterList?[indexPath.row] {
            self.performSegue(withIdentifier: kShowNovelReaderView, sender: cur)
        }
    }
}

extension NovelChapterViewController {
    
    func setupToolBar() {

//        let searchBar = FTSearchBar(frame: CGRect(origin: .zero, size: CGSize(width: 300, height: 44)), textColor: .white)
//        searchBar.placeholder = "Search"
//        searchBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.navigationItem.titleView = searchBar

        self.setupNavigationbar(
            title: "",
            leftButton: UIBarButtonItem(itemType: .stop),
            rightButton: UIBarButtonItem(itemType: .bookmarks)
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
