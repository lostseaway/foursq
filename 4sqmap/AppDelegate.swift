//
//  AppDelegate.swift
//  4sqmap
//
//  Created by LostSeaWay on 12/30/2558 BE.
//  Copyright © 2558 LostSeaWay. All rights reserved.
//

import UIKit
import GoogleMaps
import SlideMenuControllerSwift
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private func createMenuView() {
        
        // create viewController code...
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MapViewController
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftMenuViewController
        let rightViewController = storyboard.instantiateViewControllerWithIdentifier("RightViewController") as! RightMenuViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        SlideMenuOptions.rightPanFromBezel = false

        let slideMenuController = SlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController, rightMenuViewController: rightViewController)

        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyBYMlGsnAm2MJUWx_6RRa4L91J3c4vbSfg")
        
        self.createMenuView()
        return true
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

