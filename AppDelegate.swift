//
//  AppDelegate.swift
//  csci571
//
//  Created by JIN QU on 20/11/2016.
//  Copyright © 2016 JIN QU. All rights reserved.
//

import UIKit
//import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
//    fileprivate func createMenuView() {
//        
//        // create viewController code...

//    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let appearance = UITabBarItem.appearance()
        let attributes = [NSFontAttributeName:UIFont(name: "Arial", size: 18)!]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        
//                let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//                let mainViewController = storyboard.instantiateViewController(withIdentifier: "legislators") as! legiTabBarController
//                let leftViewController = storyboard.instantiateViewController(withIdentifier: "left") as! LeftViewController
//                //let rightViewController = storyboard.instantiateViewController(withIdentifier: "RightViewController") as! RightViewController
//        
//                let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
//        
//                //UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
//        
//                leftViewController.legiViewController = nvc
//        
//                let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
//                slideMenuController.automaticallyAdjustsScrollViewInsets = true
//                //slideMenuController.delegate = mainViewController
//                self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
//                //self.window?.rootViewController = slideMenuController
//                self.window?.makeKeyAndVisible()
        
        //self.createMenuView()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

