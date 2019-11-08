//
//  AppDelegate.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = ViewController()
        let trackingManager = TrackingManager()
        let repository = ViewRepository()
        let presenter = ViewPresenter(viewInput: viewController, trackingManager: trackingManager)
        presenter.repositoryInput = repository
        viewController.viewOutput = presenter

        let onez = try? FibonacciUtility().generateFibonacciNumber(for: 0)
        let one = try? FibonacciUtility().generateFibonacciNumber(for: 1)
        let one1 = try? FibonacciUtility().generateFibonacciNumber(for: 2)
        let one2 = try? FibonacciUtility().generateFibonacciNumber(for: 3)
        let one3 = try? FibonacciUtility().generateFibonacciNumber(for: 4)
        let one4 = try? FibonacciUtility().generateFibonacciNumber(for: 5)
        let one5 = try? FibonacciUtility().generateFibonacciNumber(for: 8)

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        set(viewModel: true)
        return true
    }

    func set(viewModel: Bool?) {
        if let vm = viewModel {
            do {
                print(vm)
            }
        }
        print("blah blah")
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

