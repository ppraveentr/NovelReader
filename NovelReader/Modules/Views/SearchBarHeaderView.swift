//
//  SearchBarHeaderView.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class SearchBarHeaderView: FTView {
    var searchBar: UISearchBar?
    weak var searchBarDelegate: UISearchBarDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSearchBar()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupSearchBar()
    }

    convenience init(delegate: UISearchBarDelegate) {
        self.init()
        searchBarDelegate = delegate
        searchBar?.delegate = delegate
    }

    func setupSearchBar() {

        self.theme = ThemeStyle.defaultStyle

        searchBar = UISearchBar(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 44)))
        searchBar?.theme = ThemeStyle.defaultStyle
        searchBar?.delegate = searchBarDelegate

        if let searchBar = searchBar {
            searchBar.placeholder = "Search"
            searchBar.autoresizingMask = .flexibleHeight
            self.pin(view: searchBar, edgeOffsets: .zero)
        }
    }
}
