//
//  NRAppManager.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

class NRAppManager {

    // MARK: Setup
    static func setupApplication() {
        NRAppManager.configureAppBase()
        NRAppManager.configureAppTheme()
        //NRGoogleAuth.setupGoogleAuth()
    }

    // MARK: Model Binding
    static func configureAppBase() {

        // Register self's type as Bundle-Identifier for getting class name
        FTReflection.registerModuleIdentifier(NRAppDelegate.self)

        // Service Binding
        FTMobileConfig.serviceBindingPath = kServiceBindingsName
        FTMobileConfig.serviceBindingRulesName = kServiceBindingRulesName

        // App Config
        FTMobileConfig.appBaseURL = NRAppManager.endpointURL()

        // Debug-only code
        self.configDebug()

        MSAppCenter.start(kMSAppCenter, withServices:[
            MSAnalytics.self,
            MSCrashes.self
            ])
    }

    // plist Endpoint
    static func endpointURL() -> String {
        return Bundle.main.infoDictionary![kEndpointURL] as? String ?? ""
    }

    // Config
    static func configDebug() {
//        #if DEBUG
        // Console Loggin
        FTLogger.enableConsoleLogging = true
        // Debug-Postman
//        FTMobileConfig.appBaseURL = kPostmanURL
        // Debug-only code
        FTMobileConfig.appBaseURL = kMockServerURL
        FTMobileConfig.mockBundleResource = kMockBundleResource
        FTMobileConfig.isMockData = kMockDataEnabled
//        #endif
    }

    static func generateModelBinding() {
        // Model Binding Generator
        if let resourcePath = Bundle.main.resourceURL {
            FTModelCreator.configureSourcePath(path: resourcePath.appendingPathComponent(kModelBindingsName).path)
            FTModelCreator.generateOutput()
        }
    }

    // MARK: Theme
    static func configureAppTheme() {

        if
            let theme = Bundle.main.path(forResource: kThemeFileName, ofType: nil),
            let themeContent: FTThemeModel = try! theme.jsonContentAtPath() {

            FTThemesManager.setupThemes(themes: themeContent, imageSourceBundle: [Bundle(for: NRAppDelegate.self)])
        }

//        let toolBarAppearance = UIToolbar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
//        toolBarAppearance.barTintColor = .white
//        toolBarAppearance.isTranslucent = true

        //        let textBarAppearance = UILabel.appearance(whenContainedInInstancesOf: [FTSearchBar.self])
        //        textBarAppearance.tintColor = .blue

        //Status Bar 
        FTThemesManager.setStatusBarBackgroundColor(kNavigationBarColor)

        // WARNING :
        // UIApplication.shared.statusBarStyle = .lightContent

        //Loading Indicator
        setupLoadingIndicator()
    }

    // MARK: LoadingIndicator
    static func setupLoadingIndicator() {

        var config: FTLoadingIndicator.Config = FTLoadingIndicator.Config()
        config.backgroundColor = UIColor.clear
        config.spinnerColor = kNavigationBarColor
        config.titleTextColor = UIColor.white
        config.spinnerLineWidth = 8.0
        config.foregroundColor = kNavigationBarColor.darkerColor(30)
        config.foregroundAlpha = 0.5
        config.title = ""

        FTLoadingIndicator.setConfig(config: config)
    }

}
