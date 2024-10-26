//
//  TableViewDataManager.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/06/21.
//  Copyright © 2021 Praveen Prabhakar. All rights reserved.
//

import AppTheming
import CoreComponents
import CoreUtility
import Foundation
import NetworkLayer
import UIKit

// MARK: Configure protocol
protocol DSConfigureContentProtocol {
    func configureContent(content: AnyObject, indexPath: IndexPath?)
}

public extension DataSourceManager {
    typealias DataObjects = [[AnyObject]]
    // Collection View
    typealias DequeueReusableViewReturn = (type: UICollectionReusableView.Type, block: ActionWithObjectBlock?)
    typealias DequeueReusableViewBlock = (_ indexPath: IndexPath, _ kind: String) -> DequeueReusableViewReturn
    typealias ReferenceSizeBlock = (_ section: Int) -> UICollectionReusableView?
    // Common
    typealias DequeueViewBlock = (_ indexPath: IndexPath) -> UIView.Type
    typealias DidSelectCellBlock = (_ indexPath: IndexPath, _ object: AnyObject) -> Void
}

open class DataSourceManager: NSObject {
    var cellObjects = DataObjects()
    var dequeueView: DequeueViewBlock?
    var dequeueReusableView: DequeueReusableViewBlock?
    var configureDidSelect: DidSelectCellBlock?
    var layoutReferenceSize: ReferenceSizeBlock?

    var tableDelegate: TableViewControllerProtocol? {
        didSet {
            configureTable(delegate: self, source: self)
        }
    }
    var collectionDelegate: CollectionViewControllerProtocol? {
        didSet {
            configureCollection(delegate: self, source: self)
        }
    }
    
    init(delegate: TableViewControllerProtocol? = nil, collectionDelegate: CollectionViewControllerProtocol? = nil) {
        super.init()
        self.tableDelegate = delegate
        self.collectionDelegate = collectionDelegate
        configureDataSource()
    }
}

// MARK: Common
extension DataSourceManager {
    func configureDataSource() {
        self.configureTable(delegate: self, source: self)
        self.configureCollection(delegate: self, source: self)
    }
    
    func reloadView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
            self?.collectionView?.reloadData()
        }
    }
    func removeAllObjects() {
        cellObjects.removeAll()
        reloadView()
    }

    func updateCellObjects(_ objects: DataObjects) {
        cellObjects.removeAll()
        cellObjects = objects
        reloadView()
    }
    
    func getObject(for indexPath: IndexPath) -> AnyObject? {
        let (section, row) = (indexPath.section, indexPath.row)
        guard section < cellObjects.count else { return nil }
        let sectionObj = cellObjects[section]
        guard row < sectionObj.count else { return nil }
        return sectionObj[row]
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource
extension DataSourceManager: UITableViewDelegate, UITableViewDataSource {
    var tableView: UITableView? {
        tableDelegate?.tableView
    }
    
    func register(_ cellType: UITableViewCell.Type) {
        guard let view = tableView else { return }
        if cellType.hasNib {
            cellType.registerNib(for: view)
        } else {
            cellType.registerClass(for: view)
        }
    }

    func configureTable(delegate: UITableViewDelegate? = nil, source: UITableViewDataSource? = nil) {
        guard let tableView = tableView else { return }
        // Setup TableView
        tableView.theme = ThemeStyle.defaultStyle.rawValue
        // TableView delegates
        tableView.dataSource = source
        tableView.delegate = delegate
        // Relaod TableView onces
        DispatchQueue.main.async { [weak tableView] in
            tableView?.reloadData()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < cellObjects.count else { return 0 }
        return cellObjects[section].count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dequeueObj = dequeueView?(indexPath) as? UITableViewCell.Type,
              let cellType = try? dequeueObj.dequeue(from: tableView, for: indexPath) else {
            return UITableViewCell()
        }
        if let obj = getObject(for: indexPath), let cell = cellType as? DSConfigureContentProtocol {
            cell.configureContent(content: obj, indexPath: indexPath)
        }
        return cellType
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let obj = getObject(for: indexPath) {
            configureDidSelect?(indexPath, obj)
        }
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension DataSourceManager {
    var collectionView: UICollectionView? {
        collectionDelegate?.collectionView
    }
    
    func register(_ viewType: UIView.Type, kind: String? = nil) {
        guard let view = collectionView else { return }
        if let cellType = viewType as? UICollectionReusableView.Type, let kind = kind {
            if cellType.hasNib {
                cellType.registerNib(for: view, forSupplementaryViewOfKind: kind)
            } else {
                cellType.registerClass(for: view, forSupplementaryViewOfKind: kind)
            }
        }
        if let cellType = viewType as? UICollectionViewCell.Type {
            if cellType.hasNib {
                cellType.registerNib(for: view)
            } else {
                cellType.registerClass(for: view)
            }
        }
    }

    func configureCollection(delegate: UICollectionViewDelegate? = nil, source: UICollectionViewDataSource? = nil) {
        guard let collectionView = collectionView else { return }
        // Setup TableView
        collectionView.theme = ThemeStyle.defaultStyle.rawValue
        // CollectionView delegates
        collectionView.dataSource = source
        collectionView.delegate = delegate
        // Relaod CollectionView onces
        DispatchQueue.main.async { [weak collectionView] in
            collectionView?.reloadData()
        }
    }
}

// MARK: UICollectionView delegates
extension DataSourceManager: UICollectionViewDelegate, UICollectionViewDataSource {
    // viewForSupplementaryElement
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        guard let dequeueObj = dequeueReusableView?(indexPath, kind),
              let cellType = try? dequeueObj.type.dequeue(from: collectionView, ofKind: kind, for: indexPath) else {
            return UICollectionReusableView()
        }
        dequeueObj.block?(cellType)
        return cellType
    }

    // numberOfItemsInSection
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard section < cellObjects.count else { return 0 }
        return cellObjects[section].count
    }

    // cellForItem
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dequeueObj = dequeueView?(indexPath) as? UICollectionViewCell.Type,
              let cellType = try? dequeueObj.dequeue(from: collectionView, for: indexPath) else {
            return UICollectionViewCell()
        }
        if let obj = getObject(for: indexPath), let cell = cellType as? DSConfigureContentProtocol {
            cell.configureContent(content: obj, indexPath: indexPath)
        }
        return cellType
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let view = layoutReferenceSize?(section) else { return .zero }
        let height = view.preferredLayoutAttributesFitting(.init()).frame.height
        return CGSize(width: view.frame.width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let obj = getObject(for: indexPath) else { return }
        configureDidSelect?(indexPath, obj)
    }
}
