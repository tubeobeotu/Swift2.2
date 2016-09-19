//
//  MainView.swift
//  iHotel
//
//  Created by DangCan on 1/26/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit


class MainView: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    var profileImg = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "observeProfileChange:",
            name: FBSDKProfileDidChangeNotification,
            object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(
//            self,
//            selector: "observeTokenChange:",
//            name: FBSDKAccessTokenDidChangeNotification,
//            object: nil)
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        
        getNameProfile()
//        if (FBSDKAccessToken.currentAccessToken() == nil)
//        {
//            print("not logged in ..")
//        }
//        else
//        {
//            print("logged in ...")
//        }
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = []
        loginButton.delegate = self
        
        //        //google
        //        let signInButton = GIDSignInButton()
        //        signInButton.center = CGPointMake(self.view.center.x, self.view.center.y - 100)
        //        self.view.addSubview(signInButton)
        //        let signIn = GIDSignIn.sharedInstance()
        //        signIn.shouldFetchBasicProfile = true
        //        signIn.delegate = self
        //        signIn.uiDelegate = self
        
    }
    //    //google
    //    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
    //        if (error == nil)
    //        {
    //            print("Login google complete")
    //        }
    //        else
    //        {
    //            print(error.localizedDescription)
    //        }
    //    }
    //
    //
    //    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
    //        print("User logged out...")
    //    }
    
    //facebook
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if (error == nil)
        {
            print("Login complete")
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User logged out...")
    }
    func observeProfileChange(notfication: NSNotification)
    {
        
        getNameProfile()
    }
//    func observeTokenChange(notfication: NSNotification)
//    {
//        let title = "Sử dụng tài khoản khách"
//        continueButton.setTitle(title, forState: .Normal)
//    }
    func getNameProfile()
    {
        if ((FBSDKProfile.currentProfile()) != nil)
        {
            let profile = FBSDKProfile.currentProfile()
            AlamofireRequest.sharedInstance.getImage("http://graph.facebook.com/\(profile.userID)/picture") { (data: NSData!) -> Void in
                if let image = UIImage(data: data)
                {
                    self.profileImg = image
                }
            }
            let title = "Sử dụng tài khoản " + profile.name
            continueButton.setTitle(title, forState: .Normal)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let viewController:HomeView = segue.destinationViewController as! HomeView
        viewController.img = profileImg
    }
    
}
