//
//  UIViewController.swift
//  Pods
//
//  Created by Ogan Topkaya on 01/04/16.
//
//

import Foundation
import UIKit

public extension UIViewController{
    
    class func initWithNib() -> Self{
        return self.init(nibName: String(describing: self), bundle: nil)
    }
    
}

public func topMostViewController() -> UIViewController?{
    if var topController = UIApplication.shared.keyWindow?.rootViewController {
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        return topController
    }
    return nil
}

