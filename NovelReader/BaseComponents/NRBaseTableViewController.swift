//
//  NRBaseTableViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

public class NRBaseTableViewController: FTBaseTableViewController {

    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.prepareSegue(segue, sender: sender)
    }
    
}
