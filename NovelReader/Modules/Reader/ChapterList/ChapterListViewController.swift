//
//  ChapterListViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import UIKit

final class ChapterListViewController: UIViewController, TableViewControllerProtocol {
    
    var novel: NovelModel?
    lazy var manager = DataSourceManager(delegate: self)
    lazy var novelDescView: NovelDetailsView? = try? .loadNibFromBundle()
    
    func tableStyle() -> UITableView.Style { .grouped }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        if let novel = novel {
            fetchNovelDetails(novel: novel)
        }
    }
}

private extension ChapterListViewController {
    func fetchNovelDetails(novel: NovelModel) {
        NovelServiceProvider.getNovelChaptersList(novel) { [weak self] novelResponse in
            guard let novelResponse = novelResponse, let self = self else {
                return
            }
            self.novel?.merge(data: novelResponse)
            self.configureContent()
        }
    }
    
    func configureTableView() {
        setupNavigationBar()
        tableView.backgroundColor = .clear
        manager.register(NovelChapterViewCell.self)
        manager.dequeueView = { indexPath -> UITableViewCell.Type in
            return NovelChapterViewCell.self
        }
        manager.configureDidSelect = { _, obj in
            self.performSegue(withIdentifier: Storyboard.Segue.showNovelReaderView, sender: obj)
        }
    }
    
    func configureContent() {
        guard let novel = novel else { return }
        novelDescView?.configureContent(content: novel)
        tableView.setTableHeaderView(view: self.novelDescView)
        if let list = novel.chapterList {
            manager.updateCellObjects([list])
        }
    }

    func setupNavigationBar() {
        self.setupNavigationbar(
            title: "",
            leftButton: UIBarButtonItem(itemType: .stop),
            rightButton: UIBarButtonItem(itemType: .bookmarks)
        )
    }
}
