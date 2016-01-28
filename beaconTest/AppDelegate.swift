//
//  AppDelegate.swift
//  beaconTest
//
//  Created by Christopher Hayduk on 1/27/16.
//  Copyright © 2016 Christopher Hayduk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ESTBeaconManagerDelegate {

    var window: UIWindow?

    let beaconManager = ESTBeaconManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.beaconManager.delegate = self
        
        self.beaconManager.requestAlwaysAuthorization()
        
        UIApplication.sharedApplication().registerUserNotificationSettings(
            UIUserNotificationSettings(forTypes: .Alert, categories: nil))
        
        ESTConfig.setupAppID("testbeacon-gkf", andAppToken: "4892df0d76d303fe8179f66686415a7e")
    
        ESTCloudManager.enableAnalytics(true)
        ESTConfig.enableRangingAnalytics(true)
        ESTConfig.enableMonitoringAnalytics(true)
        
        self.beaconManager.startMonitoringForRegion(CLBeaconRegion(
            proximityUUID: NSUUID(UUIDString: "48B34241-A2F9-40BF-A4E0-44B337310EFF")!,
            major: 1118, minor: 23964, identifier: "mint"))
            
        return true
    }
    
    func beaconManager(manager: AnyObject, didEnterRegion region: CLBeaconRegion) {
        let notification = UILocalNotification()
        notification.alertBody =
            "You are now in range of the beacon. " +
            "The test worked! " +
            "Congratulations! " +
        "Now try to run analytics."
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        
        NSLog("didEnterRegion, will automatically record an enter")
    }
    
    func beaconManager(manager: AnyObject, didExitRegion region: CLBeaconRegion) {
        let notification = UILocalNotification()
        notification.alertBody =
            "You have exited the region."
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)

        NSLog("didExitRegion, will automatically record an exit")
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

