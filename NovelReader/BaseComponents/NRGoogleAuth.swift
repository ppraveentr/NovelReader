//
//  NRGoogleAuth.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation
//import GoogleSignIn

// Notification constans name
public extension Notification.Name {
    //  FTAuthentication - Google
    static let kFTAuthenticationGoogleSignInSignedIn = Notification.Name("kFTAuthentication.GoogleSignIn.SignedIn")
    static let kFTAuthenticationGoogleSignInSignedOut = Notification.Name("kFTAuthentication.GoogleSignIn.SignedOut")
}

class NRGoogleAuth: NSObject, GIDSignInDelegate {

    static let sharedInstance = NRGoogleAuth()

    static func setupGoogleAuth() {

        FTThemesManager.addImageSourceBundle(imageSource: "GoogleSignIn".bundle())

        // Initialize sign-in
//       GIDSignIn.sharedInstance().clientID = "769359482558-l9uifqdbpq49n1pjqk6vvb2qtekm0ktl.apps.googleusercontent.com"
//       GIDSignIn.sharedInstance().delegate = NRGoogleAuth.sharedInstance
//       GIDSignIn.sharedInstance().uiDelegate = NRGoogleAuth.sharedInstance
//
//       Uncomment to automatically sign in the user.
//       GIDSignIn.sharedInstance().signInSilently()
    }

    static func signInButton() -> UIButton {

        let signButtton = UIButton(type: .custom)
        signButtton.theme = "googleButton"
        signButtton.addSizeConstraint(44, 44)

        // Update with User Profile
        if let profile = GIDSignIn.sharedInstance().currentUser?.profile {
            profile.imageURL(withDimension: 44).downloadedImage {
                signButtton.setImage($0, for: .normal)
            }
        }

        // Update with User Profile after SignIn
        _ = NotificationCenter.default.addObserver(forName: .kFTAuthenticationGoogleSignInSignedIn, object: nil, queue: nil) { (notification: Notification) in
            if let userObject = notification.object as? GIDGoogleUser {
                userObject.profile.imageURL(withDimension: 44).downloadedImage { (image: UIImage?) in
                    signButtton.setImage(image, for: .normal)
                }
            }
        }

        // Remove User Profile
        _ = NotificationCenter.default.addObserver(forName: .kFTAuthenticationGoogleSignInSignedOut, object: nil, queue: nil) { _ in
            signButtton.theme = "googleButton"
        }

        // SignIn Button Tap Action
        signButtton.addTapActionBlock {
//            if ((GIDSignIn.sharedInstance().uiDelegate != nil) || (GIDSignIn.sharedInstance().delegate != nil)) {
//                GIDSignIn.sharedInstance().signIn()
//            }
        }

        return signButtton
    }

    // GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if let error = error {
            print("\(error.localizedDescription)")
        }
        else {
            NotificationCenter.default.post(name: .kFTAuthenticationGoogleSignInSignedIn, object: user)
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        }
        else {
            NotificationCenter.default.post(name: .kFTAuthenticationGoogleSignInSignedOut, object: user)
        }
    }

    // GIDSignInUIDelegate
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) { }

    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        NRAppDelegate.getRootController()?.present(viewController, animated: true, completion: nil)
    }

    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        NRAppDelegate.getRootController()?.dismiss(animated: true, completion: nil)
    }
}

extension NRAppDelegate {

    static func getRootController() -> UIViewController? {
        if let appDelegate = UIApplication.shared.delegate as? NRAppDelegate {
            return appDelegate.window?.rootViewController
        }
        return UIApplication.shared.delegate?.window??.rootViewController
    }

//    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
//        -> Bool {
//            return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//                                                     annotation: options[UIApplication.OpenURLOptionsKey.annotation])
//    }
    
}
