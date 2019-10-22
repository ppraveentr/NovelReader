//
//  NRBaseViewController.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

public class NRBaseViewController: UIViewController {

    public override func loadView() {
        super.loadView()
        setupCoreView()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideBottomBar(false)
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideBottomBar(false)
    }

    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideBottomBar(true)
    }

    func hideBottomBar(_ isHidden: Bool) {
        self.tabBarController?.tabBar.isHidden = isHidden
    }
}
