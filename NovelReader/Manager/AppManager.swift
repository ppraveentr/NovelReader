//
//  AppManager.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import AppTheming
import CoreComponents
import CoreUtility
import NetworkLayer

// MSAppCenter
#if canImport(AppCenter)
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
#endif

final class AppManager {
    static var kBundle = Bundle(for: AppDelegate.self)

    // plist Endpoint
    static var endpointURL: String {
        Bundle.main.infoDictionary?[EndPoint.endpointURL] as? String ?? ""
    }
    
    // MARK: Setup
    static func setupApplication() {
        AppManager.configureAppBase()
        AppManager.configureAppTheme()
        // NRGoogleAuth.setupGoogleAuth()
    }

    // MARK: Model Binding
    static func configureAppBase() {
        // Service Binding
        NetworkMananger.serviceBindingPath = EndPoint.serviceBindingsName
        NetworkMananger.serviceBindingRulesName = EndPoint.serviceBindingRulesName

        // App Config
        NetworkMananger.appBaseURL = AppManager.endpointURL

        // Debug-only code
        self.configDebug()
    }

    // Config
    static func configDebug() {
        #if DEBUG
        // Console Loggin
        Logger.enableConsoleLogging = true
        // Debug-Postman
//        FTMobileConfig.appBaseURL = kPostmanURL
        // Debug-only code
        NetworkMananger.appBaseURL = EndPoint.Mock.mockServerURL
        NetworkMananger.mockBundleResource = EndPoint.Mock.mockBundleResource
        NetworkMananger.isMockData = EndPoint.Mock.mockDataEnabled
        #endif
    }
    
    func configureAppCenter() {
        #if canImport(AppCenter)
//        MSAppCenter.start(kMSAppCenter, withServices:[
//            MSAnalytics.self,
//            MSCrashes.self
//            ])
        #endif
    }
    
    func configureGoogleAuth() {
        #if canImport(GoogleSignIn)
//        NRGoogleAuth.setupGoogleAuth()
        #endif
    }

    // MARK: Theme
    static func configureAppTheme() {
        if let theme = Bundle.main.path(forResource: AppTheme.fileName, ofType: nil),
            let themeContent: ThemeModel = try? theme.jsonContentAtPath() {
            ThemesManager.setupThemes(themes: themeContent, imageSourceBundle: [kBundle])
        }
        
        // Loading Indicator
        setupLoadingIndicator()
    }

    // MARK: LoadingIndicator
    static func setupLoadingIndicator() {
        var config = LoaderConfig()
        config.backgroundColor = UIColor.clear
        config.spinnerColor = AppTheme.navigationBarColor
        config.titleTextColor = UIColor.white
        config.spinnerLineWidth = 8.0
        config.foregroundColor = AppTheme.barColor
        config.foregroundAlpha = 0.8
        config.title = ""
        LoadingIndicator.setConfig(config: config)
    }
}
