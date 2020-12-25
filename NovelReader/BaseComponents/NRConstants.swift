//
//  NRConstants.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 28/09/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation

// MARK: Application Theme
let kThemeFileName = "Themes.json"
var kNavigationBarColor: UIColor {
    return "#DF6E6E".hexColor() ?? UIColor.white
}
var kBarColor: UIColor {
     return "#de6161".hexColor() ?? UIColor.black
}

let kReaderFontSize = 10
let kReaderInitalFontSize = 140

// MARK: Service URL
let kEndpointURL = "EndpointURL"
let kModelBindingsName = "Bindings/ModelBindings"
let kServiceBindingsName = "Bindings/ServiceBindings"
let kServiceBindingRulesName = "NovelServiceRules.plist"

// MARK: 3rd Party
let kMSAppCenter = "6778a47c-7742-4dea-ace3-63c28b424350"

// MARK: Mock
let kPostmanURL = "https://9b5d34ef-b082-479b-87cb-a845d678b371.mock.pstmn.io"
let kMockServerURL = "http://127.0.0.1:3000"
let kMockBundleResource = "FTNovelReaderMockBundle.bundle".bundleURL()
let kMockDataEnabled = true

// MARK: Constantss
let kServiceFailureAlertTitle = "Service Error!"
let kServiceFailureAlertMessage = "Unable to reach service host, please try again."

// MARK: App
let kRetryString = "Retry"
let kRecentUpdateString = "Recent Update"
let kTopViews = "Top Views"

// MARK: Title
let kNovelReaderTitle = "Novel Reader"

// MARK: StoryboardID
let kSearchStoryboardID = "kSearchStoryboardID"

// MARK: SegueID
let kShowNovelChapterList = "kShowNovelChapterList"
let kShowFontPicker = "kShowFontPicker"
let kShowNovelReaderView = "kShowNovelReaderView"
