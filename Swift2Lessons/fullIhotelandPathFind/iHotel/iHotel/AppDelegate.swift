//
//  AppDelegate.swift
//  iHotel
//
//  Created by DangCan on 1/19/16.
//  Copyright © 2016 DangCan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Arial-BoldMT", size: 25)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().barTintColor = UIColor(red: 4/255, green: 190/255, blue: 231/255, alpha: 1)
        application.setStatusBarHidden(false, withAnimation: .None)
        application.setStatusBarStyle(.LightContent, animated: false)
        GIDSignIn.sharedInstance().clientID = "846719171660-postnh0m443loqfivjs1uljog5v4tu78.apps.googleusercontent.com"
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    func application(app: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        return (FBSDKApplicationDelegate.sharedInstance().application(app, openURL: url, sourceApplication: sourceApplication, annotation: annotation) ||
            GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation))
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

