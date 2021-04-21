//
//  AppDelegate.swift
//  wippysample
//
//  Created by Woncheol Heo on 2021/04/09.
//

import UIKit
import WiseTracker

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainVC = UINavigationController(rootViewController: OurTownRankingViewController())
        mainVC.isNavigationBarHidden = true
        window?.rootViewController = mainVC
        
        return true
    }
}

