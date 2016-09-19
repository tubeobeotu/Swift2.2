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


class MainView: UIViewController, FBSDKLoginButtonDelegate, GIDSignInDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var signOut: UIButton!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var profileName : UILabel!
    @IBOutlet weak var loginGoogle: GIDSignInButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "observeProfileChange:",
            name: FBSDKProfileDidChangeNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "observeTokenChange:",
            name: FBSDKAccessTokenDidChangeNotification,
            object: nil)
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.translucent = true
//        self.navigationController?.view.backgroundColor = UIColor.clearColor()
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = []
        loginButton.delegate = self
        
        let signIn = GIDSignIn.sharedInstance()
        signIn.shouldFetchBasicProfile = true
        signIn.delegate = self
        signIn.uiDelegate = self
        if let _ = GIDSignIn.sharedInstance().currentUser
        {
            getProfileInFoGoogle()
        }
        else
        {
            getProfileInfoFacebook()
            
        }
    }
    @IBAction func CloseView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //google
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        if (error == nil)
        {
            print("Login google complete")
            getProfileInFoGoogle()
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        getProfileInFoGoogle()
    }
    func getProfileInFoGoogle()
    {
        profileName.text = ""
        if let user = GIDSignIn.sharedInstance().currentUser
        {
            setImgButton(true)
            var title = "Sử dụng tài khoản google:"
            
            if (user.profile != nil)
            {
                let login = FBSDKLoginManager()
                if ((FBSDKAccessToken.currentAccessToken()) != nil)
                {
                    login.logOut()
                }
                AlamofireRequest.sharedInstance.getImage(user.profile.imageURLWithDimension(200).absoluteString) { (data: NSData!) -> Void in
                    if let image = UIImage(data: data)
                    {
                        self.imgProfile.image = image
                    }
                }
                title = title + user.profile.name
                profileName.text = title
                
            }
            else
            {
                self.setImageProfile(UIImage())
            }
        }
        else
        {
            setImgButton(false)
        }
    }
    func setImgButton(login: Bool)
    {
        if (login)
        {
            signOut.setImage(UIImage(named: "logoutGoogle"), forState: .Normal)
        }
        else
        {
            signOut.setImage(UIImage(named: "loginGoogle"), forState: .Normal)
        }
        
    }
    @IBAction func signOut(sender: AnyObject) {
        if let _ = GIDSignIn.sharedInstance().currentUser
        {
            GIDSignIn.sharedInstance().disconnect()
        }
        else
        {
            GIDSignIn.sharedInstance().signIn()
        }
    }
    
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
        
        getProfileInfoFacebook()
    }
    func observeTokenChange(notfication: NSNotification)
    {
//        self.setImageProfile(UIImage())
        //            continueButton.setTitle(title, forState: .Normal)
    }
    func getProfileInfoFacebook()
    {
        profileName.text = ""
        var title = "Sử dụng tài khoản Facebook:"
        if ((FBSDKProfile.currentProfile()) != nil)
        {
            if ((GIDSignIn.sharedInstance().currentUser) != nil)
            {
                GIDSignIn.sharedInstance().disconnect()
            }
            let profile = FBSDKProfile.currentProfile()
            AlamofireRequest.sharedInstance.getImage("http://graph.facebook.com/\(profile.userID)/picture?type=large") { (data: NSData!) -> Void in
                if let image = UIImage(data: data)
                {
                    self.imgProfile.image = image
                }
            }
            title = title + profile.name
            profileName.text = title
        }
        else
        {
            self.setImageProfile(UIImage())
        }
        //        continueButton.setTitle(title, forState: .Normal)
    }
    func setImageProfile(imgPro: UIImage)
    {
        let size = CGSize(width: 0, height: 0)
        if (imgPro.size.width != size.width)
        {
                imgProfile.image = imgPro
        }
        else
        {
            imgProfile.image = UIImage(named: "profile")
        }
    }

    
}
