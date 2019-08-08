//
//  NRAppManager.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

#if canImport(AppCenter)
//MSAppCenter
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
#endif

final class NRAppManager {

    static let sharedInstance = NRAppManager()
    
    // plist Endpoint
    static var endpointURL: String {
        return Bundle.main.infoDictionary?[kEndpointURL] as? String ?? ""
    }
    
    // MARK: Setup
    static func setupApplication() {
        NRAppManager.sharedInstance.configureAppBase()
        NRAppManager.sharedInstance.configureAppTheme()
        //GoogleSignIn
        #if canImport(GoogleSignIn)
        NRAppManager.sharedInstance.configureGoogleAuth()
        #endif
        //MSAppCenter
        NRAppManager.sharedInstance.configureAppCenter()
    }

    // MARK: Model Binding
    func configureAppBase() {

        // Register self's type as Bundle-Identifier for getting class name
        FTReflection.registerModuleIdentifier(NRAppDelegate.self)

        // Service Binding
        FTMobileConfig.serviceBindingPath = kServiceBindingsName
        FTMobileConfig.serviceBindingRulesName = kServiceBindingRulesName

        // App Config
        FTMobileConfig.appBaseURL = NRAppManager.endpointURL

        // Debug-only code
        self.configDebug()
    }

    // Config
    func configDebug() {
        #if DEBUG
        // Console Loggin
        FTLogger.enableConsoleLogging = true
        // Debug-Postman
//        FTMobileConfig.appBaseURL = kPostmanURL
        // Debug-only code
//        FTMobileConfig.appBaseURL = kMockServerURL
        FTMobileConfig.mockBundleResource = kMockBundleResource
        FTMobileConfig.isMockData = kMockDataEnabled
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
        NRGoogleAuth.setupGoogleAuth()
        #endif
    }

    func generateModelBinding() {
        // Model Binding Generator
        if let resourcePath = Bundle.main.resourceURL {
            FTModelCreator.configureSourcePath(path: resourcePath.appendingPathComponent(kModelBindingsName).path)
            FTModelCreator.generateOutput()
        }
    }

    // MARK: Theme
    func configureAppTheme() {

        if
            let theme = Bundle.main.path(forResource: kThemeFileName, ofType: nil),
            let themeContent: FTThemeModel = try? theme.jsonContentAtPath() {
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
    func setupLoadingIndicator() {

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
