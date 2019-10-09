//
//  AppDelegate.swift
//  Walking_alarm_clock
//
//  Created by Jackson Ho on 9/9/19.
//  Copyright © 2019 Jackson Ho. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    Persistent.shared.checkPermission {
        Persistent.shared.center.requestAuthorization { (granted) in
            print(granted)
        }
    }
    
    window = UIWindow(frame: UIScreen.main.bounds)
    
    if let window = window {
        let layout = UICollectionViewFlowLayout()
        let homeVC = HomeCollectionViewController(collectionViewLayout: layout)
        layout.sectionInset = UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 20)
        layout.minimumLineSpacing = 50
//
        window.rootViewController = UINavigationController(rootViewController: homeVC)
        
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "HomeCollectionViewController") as? HomeCollectionViewController
//        window.rootViewController = UINavigationController(rootViewController: viewController!)
       
// uncomment the following, and comment out the above to display wake up screen, instead of alarms collection view
//        let wakeupScreenVC = UIStoryboard(name: "Main",bundle: nil).instantiateViewController(withIdentifier: "WakeUpScreenViewController")
//        window.rootViewController = wakeupScreenVC

        window.makeKeyAndVisible()
    }
    
    // Override point for customization after application launch.
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

extension AppDelegate: UNUserNotificationCenterDelegate {
}
