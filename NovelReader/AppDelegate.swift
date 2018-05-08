//
//  AppDelegate.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import UIKit

@UIApplicationMain
class NRAppDelegate: FTAppDelegate {

    open override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        
        NRAppManager.configureAppBase()
        NRAppManager.configureAppTheme()
        NRGoogleAuth.setupGoogleAuth()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func setUpFloatingView() {

        //        let floatingView = (UIApplication.shared.delegate as? NRAppDelegate)?.floatingButton

        //        floatingView?.show()

        //        var novels = NRNovelChapter(title: "title", url: (Bundle.main.path(forResource: "EmperorDominationChapter", ofType: "html")!))
        //        NRServiceProvider.parseNovelReader(&novels)
        //
        //        self.performSegue(withIdentifier: "kShowNovelReaderView", sender: novels)


        //        NotificationCenter.default.addObserver(forName: .FTMobileCoreUI_ViewController_DidAppear, object: self, queue: nil) { (not) in
        //
        //        }
        //
        //        NotificationCenter.default.addObserver(forName: .FTMobileCoreUI_ViewController_WillDisappear, object: self, queue: nil) { (not) in
        //
        //        }
    }
}
