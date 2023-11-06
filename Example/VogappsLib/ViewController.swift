//
//  ViewController.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 11/30/2015.
//  Copyright (c) 2015 Ogan Topkaya. All rights reserved.
//

import UIKit
import VogappsLib
import FBSDKLoginKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        textField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func presentPopup(_ sender: AnyObject) {
//        let inAppPopup = InAppPopup.create()
//        inAppPopup.present()        
    }
    
    @IBAction func loginToFacebook(_ sender: Any) {
//        Facebook.login(permissions: [.publicProfile, .userFriends])
//            .done { token -> Void in
//                print(token)
//            }
        
        
//        Facebook.login(permissions: [.publicProfile, .userFriends]).then{ accessToken in
//            print("\(accessToken)")
//        }
        
        _ = Facebook.getProfile().done{ profile in
            print(profile)
        }
        
    }
    
    @IBAction func getFriends(_ sender: Any) {
        _ = Facebook.getInstalledFriends().done{friends -> Void in
            print(friends)
        }

//        _ = Facebook.roster().done { roster -> Void in
//            print(roster)
//        }
        
    }
    
}

