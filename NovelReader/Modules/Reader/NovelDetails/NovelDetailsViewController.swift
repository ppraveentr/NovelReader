//
//  NovelDetailsViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 27/06/21.
//  Copyright © 2021 Praveen Prabhakar. All rights reserved.
//

import UIKit

final class NovelDetailsViewController: UIViewController, TableViewControllerProtocol {
    
    var novel: NovelModel?
    lazy var novelDescView: NovelDetailsView? = NovelDetailsView.fromNib() as? NovelDetailsView
    
    func tableStyle() -> UITableView.Style { .grouped }

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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        NovelChapterViewCell.registerNib(for: tableView)
    }
    
    func configureContent(content: AnyObject) {
        if let content = content as? NovelModel {
            self.novelDescView?.configureContent(content: content)
            self.tableView.setTableHeaderView(view: self.novelDescView)
            self.tableView.reloadData()
        }
    }
}

extension NovelDetailsViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        novel?.chapterList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = try? NovelChapterViewCell.dequeue(from: tableView, for: indexPath) else {
            return UITableViewCell()
        }
        
        if
            let cell = cell as? NovelChapterViewCell,
            let cur = novel?.chapterList?[indexPath.row] {
            cell.configureContent(content: cur)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cur = novel?.chapterList?[indexPath.row] {
            self.performSegue(withIdentifier: Storyboard.Segue.showNovelReaderView, sender: cur)
        }
    }
}
