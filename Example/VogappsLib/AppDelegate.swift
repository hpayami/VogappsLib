//
//  AppDelegate.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 11/30/2015.
//  Copyright (c) 2015 Ogan Topkaya. All rights reserved.
//

import UIKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }

    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return ApplicationDelegate.shared.application(app,open: url,options: options)
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return ApplicationDelegate.shared.application(application,open: url,options: [UIApplication.OpenURLOptionsKey.sourceApplication : sourceApplication!,UIApplication.OpenURLOptionsKey.annotation : annotation])
    }
    

}

