//
//  NRSearchFilterViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 13/10/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRSearchFilterViewController: NRBaseViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NRServiceProvider.searchFilter { (filter) in
            print(filter ?? "")
        }
    }
}
