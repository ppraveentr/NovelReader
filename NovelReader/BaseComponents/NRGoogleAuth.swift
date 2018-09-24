//
//  NRGoogleAuth.swift
//  NovelReader
//
//  Created by Praveen Prabhakar on 30/04/18.
//  Copyright © 2018 Praveen Prabhakar. All rights reserved.
//

import Foundation
import GoogleSignIn

//Notification constans name
public extension Notification.Name {
    //FTAuthentication - Google
    public static let FTAuthentication_GoogleSignIn_SignedIn = Notification.Name("FTAuthentication_GoogleSignIn_SignedIn")
    public static let FTAuthentication_GoogleSignIn_SignedOut = Notification.Name("FTAuthentication_GoogleSignIn_SignedOut")

}

class NRGoogleAuth: NSObject, GIDSignInDelegate, GIDSignInUIDelegate {

    static let sharedInstance = NRGoogleAuth()

    class func setupGoogleAuth() {

        FTThemesManager.addImageSourceBundle(imageSource: "GoogleSignIn".bundle())

        // Initialize sign-in
//        GIDSignIn.sharedInstance().clientID = "769359482558-l9uifqdbpq49n1pjqk6vvb2qtekm0ktl.apps.googleusercontent.com"
//        GIDSignIn.sharedInstance().delegate = NRGoogleAuth.sharedInstance
//        GIDSignIn.sharedInstance().uiDelegate = NRGoogleAuth.sharedInstance
//
//        // Uncomment to automatically sign in the user.
//        GIDSignIn.sharedInstance().signInSilently()
    }

    class func signInButton() -> FTButton {

        let signButtton = FTButton(type: .custom)
        signButtton.theme = "googleButton"
        signButtton.addSizeConstraint(44, 44)

        //Update with User Profile
        if let profile = GIDSignIn.sharedInstance().currentUser?.profile {
            profile.imageURL(withDimension: 44).downloadedImage { (image) in
                signButtton.setImage(image, for: .normal)
            }
        }

        //Update with User Profile after SignIn
        NotificationCenter.default.addObserver(forName: .FTAuthentication_GoogleSignIn_SignedIn, object: nil, queue: nil) { (notificationn) in

            if let userObject = notificationn.object as? GIDGoogleUser {
                userObject.profile.imageURL(withDimension: 44).downloadedImage { (image) in
                    signButtton.setImage(image, for: .normal)
                }
            }
        }

        //Remove User Profile
        NotificationCenter.default.addObserver(forName: .FTAuthentication_GoogleSignIn_SignedOut, object: nil, queue: nil) { (nnnot) in
            signButtton.theme = "googleButton"
        }

        //SignIn Button Tap Action
        signButtton.addTapActionBlock {
            if ((GIDSignIn.sharedInstance().uiDelegate != nil) || (GIDSignIn.sharedInstance().delegate != nil)) {
                GIDSignIn.sharedInstance().signIn()
            }
        }

        return signButtton
    }

    //GIDSignInDelegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            NotificationCenter.default.post(name: .FTAuthentication_GoogleSignIn_SignedIn, object: user)
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            NotificationCenter.default.post(name: .FTAuthentication_GoogleSignIn_SignedOut, object: user)
        }
    }

    //GIDSignInUIDelegate
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) { }

    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        NRAppDelegate.getRootController().present(viewController, animated: true, completion: nil)
    }

    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        NRAppDelegate.getRootController().dismiss(animated: true, completion: nil)
    }
}

extension NRAppDelegate {

    class func getRootController() -> UIViewController {
        let appDelegate = UIApplication.shared.delegate as! NRAppDelegate
        return appDelegate.window!.rootViewController!
    }

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
}
