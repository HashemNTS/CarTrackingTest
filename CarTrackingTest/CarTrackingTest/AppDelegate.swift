//
//  AppDelegate.swift
//  CarTrackingTest
//
//  Created by M-Hashem on 1/30/17.
//  Copyright © 2017 M-Hashem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    internal static var domainurl = "http://qtech-system.com/interview/index.php/apis/"
    
    var window: UIWindow?
    internal static var storyboard: UIStoryboard!
    
    internal static var navControler : UINavigationController!
    
    internal static func RoutToScreen(screen: String,WithNav:Bool = true) -> UIViewController
    {
        let ViewController = storyboard!.instantiateViewController(withIdentifier: screen)
        
        if WithNav
        {
            if (navControler == nil)
            {
                navControler = storyboard!.instantiateInitialViewController()as! UINavigationController
            }
            navControler.viewControllers = [ViewController]
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        appDelegate.window!.rootViewController = WithNav ? navControler : ViewController
        
        return ViewController
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
         AppDelegate.storyboard = UIStoryboard(name: "Main", bundle: nil)
         let _ = AppDelegate.RoutToScreen(screen: "VcLogin",WithNav: false)
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

