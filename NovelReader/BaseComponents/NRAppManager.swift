//
//  NRAppManager.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 20/08/17.
//  Copyright © 2017 Praveen Prabhakar. All rights reserved.
//

import Foundation

class NRAppManager {

    class func configureAppBase() {

        //Register self's type as Bundle-Identifier for getting class name
        FTReflection.registerModuleIdentifier(NRAppDelegate.self)

        //Service Binding
        FTMobileConfig.serviceBindingPath = "Bindings/ServiceBindings"
        FTMobileConfig.serviceBindingRulesName = "NovelServiceRules.plist"

        //App Config
        FTMobileConfig.appBaseURL = NRAppManager.endpointURL()

        //Debug-only code
        self.configDebug()
    }

    class func endpointURL() -> String {
        return Bundle.main.infoDictionary!["EndpointURL"] as? String ?? ""
    }

    class func configDebug() {
        #if DEBUG
        // Debug-only code
        FTMobileConfig.appBaseURL = "http://127.0.0.1:3000"
        FTMobileConfig.mockBundleResource = "FTNovelReaderMockBundle.bundle".bundleURL()
        FTMobileConfig.isMockData = true
        #endif
    }

    class func generateModelBinding() {
        //Model Binding Generator
        if let resourcePath = Bundle.main.resourceURL {
            FTModelCreator.configureSourcePath(path: resourcePath.appendingPathComponent("Bindings/ModelBindings").path);
            FTModelCreator.generateOutput()
        }
    }

    class func configureAppTheme() {

        if
            let theme = Bundle.main.path(forResource: "Themes", ofType: "json"),
            let themeContent: FTThemeDic = try! theme.jsonContentAtPath() {

            FTThemesManager.setupThemes(themes: themeContent, imageSourceBundle: [Bundle(for: NRAppDelegate.self)])
        }

//        let toolBarAppearance = UIToolbar.appearance(whenContainedInInstancesOf: [UINavigationController.self])
//        toolBarAppearance.barTintColor = .white
//        toolBarAppearance.isTranslucent = true

        //        let textBarAppearance = UILabel.appearance(whenContainedInInstancesOf: [FTSearchBar.self])
        //        textBarAppearance.tintColor = .blue

        if let color = "#DF6E6E".hexColor() {
            FTThemesManager.setStatusBarBackgroundColor(color)
        }

        UIApplication.shared.statusBarStyle = .lightContent

    }
}
