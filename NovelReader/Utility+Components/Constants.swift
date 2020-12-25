//
//  Constants.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 28/09/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

// MARK: Application Theme
enum AppTheme {
    static let fileName = "Themes.json"
    // Color base
    static let appBase = "appBase"
    static let navBar = "navBar"
    
    static var navigationBarColor: UIColor {
        ThemesManager.getColor(AppTheme.appBase) ?? UIColor.white
    }
    
    static var barColor: UIColor {
        ThemesManager.getColor(AppTheme.navBar) ?? UIColor.black
    }
}

enum EndPoint {
    // MARK: Service URL
    static let endpointURL = "EndpointURL"
    static let modelBindingsName = "Bindings/ModelBindings"
    static let serviceBindingsName = "Bindings/ServiceBindings"
    static let serviceBindingRulesName = "NovelServiceRules.plist"
    
    // MARK: Mock
    enum Mock {
        static let postmanURL = "https://9b5d34ef-b082-479b-87cb-a845d678b371.mock.pstmn.io"
        static let mockServerURL = "http://127.0.0.1:3000"
        static let mockBundleResource = "FTNovelReaderMockBundle.bundle".bundleURL()
        static let mockDataEnabled = true
    }
    
    // MARK: 3rd Party
    static let kMSAppCenter = "6778a47c-7742-4dea-ace3-63c28b424350"
}

enum Constants {
    // MARK: Constants
    static let serviceFailureAlertTitle = "Service Error!"
    static let serviceFailureAlertMessage = "Unable to reach service host, please try again."

    // MARK: App
    static let retryString = "Retry"
    static let recentUpdateString = "Recent Update"
    static let topViews = "Top Views"
    
    // MARK: Title
    static let novelReaderTitle = "Novel Reader"
}

enum Storyboard {
    // MARK: StoryboardID
    static let searchStoryboardID = "kSearchStoryboardID"
    
    enum Segue {
        // MARK: SegueID
        static let showNovelDetailsView = "kShowNovelDetailsView"
        static let showNovelChapterList = "kShowNovelChapterList"
        static let showFontPicker = "kShowFontPicker"
        static let showNovelReaderView = "kShowNovelReaderView"
    }
}
