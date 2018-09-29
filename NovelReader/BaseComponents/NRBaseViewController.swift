//
//  NRBaseViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

let kShowNovelChapterList = "kShowNovelChapterList"
let kShowFontPicker = "kShowFontPicker"
let kShowNovelReaderView = "kShowNovelReaderView"

let kNovelCellIdentifier = "kNovelCellIdentifier"
let kRecentNovelCellIdentifier = "kRecentNovelCellIdentifier"

public class NRBaseViewController: FTBaseViewController {

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideBottomBar(false)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideBottomBar(false)
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideBottomBar(true)
    }

    func hideBottomBar(_ isHidden: Bool) {
        self.tabBarController?.tabBar.isHidden = isHidden
    }


    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.prepareSegue(segue, sender: sender)
    }
    
}
