//
//  AppManager.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

//MSAppCenter
#if canImport(AppCenter)
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
#endif

final class AppManager {

    static let sharedInstance = AppManager()
    
    // plist Endpoint
    static var endpointURL: String {
        return Bundle.main.infoDictionary?[kEndpointURL] as? String ?? ""
    }
    
    // MARK: Setup
    static func setupApplication() {
        AppManager.sharedInstance.configureAppBase()
        AppManager.sharedInstance.configureAppTheme()
        //NRGoogleAuth.setupGoogleAuth()
    }

    // MARK: Model Binding
    func configureAppBase() {
        // Register self's type as Bundle-Identifier for getting class name
        Reflection.registerModuleIdentifier(NRAppDelegate.self)

        // Service Binding
        NetworkMananger.serviceBindingPath = kServiceBindingsName
        NetworkMananger.serviceBindingRulesName = kServiceBindingRulesName

        // App Config
        NetworkMananger.appBaseURL = AppManager.endpointURL

        // Debug-only code
        self.configDebug()
    }

    // Config
    func configDebug() {
        #if DEBUG
        // Console Loggin
        Logger.enableConsoleLogging = true
        // Debug-Postman
//        FTMobileConfig.appBaseURL = kPostmanURL
        // Debug-only code
//        NetworkMananger.appBaseURL = kMockServerURL
        NetworkMananger.mockBundleResource = kMockBundleResource
        NetworkMananger.isMockData = kMockDataEnabled
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
    func configureAppTheme() {
        if let theme = Bundle.main.path(forResource: kThemeFileName, ofType: nil),
            let themeContent: ThemeModel = try? theme.jsonContentAtPath() {
            ThemesManager.setupThemes(themes: themeContent, imageSourceBundle: [Bundle(for: NRAppDelegate.self)])
        }
        
        //Loading Indicator
        setupLoadingIndicator()
    }

    // MARK: LoadingIndicator
    func setupLoadingIndicator() {

        var config: LoadingIndicator.Config = LoadingIndicator.Config()
        config.backgroundColor = UIColor.clear
        config.spinnerColor = kNavigationBarColor
        config.titleTextColor = UIColor.white
        config.spinnerLineWidth = 8.0
        config.foregroundColor = kNavigationBarColor
        config.foregroundAlpha = 0.5
        config.title = ""

        LoadingIndicator.setConfig(config: config)
    }
}
