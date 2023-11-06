//
//  Facebook.swift
//  Pods
//
//  Created by Volkan Demircin on 18/10/2016.
//
//

import Foundation
import PromiseKit
import FBSDKLoginKit
//import FacebookLogin
//import FacebookCore
//import FBSDKCoreKit
//import FBSDKLoginKit

public enum FacebookError : Error, CancellableError
{
    case failed
    case cancelled
    case unknown
    case notLoggedIn
    
    public var isCancelled: Bool {
        return self == .cancelled
    }
    
}

public struct FacebookProfile{
    public let id: String
    public let name: String
    public let email: String?
    public var pictureUrl: URL?
    
    init(_ dictionary: [String: Any]){
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.email = dictionary["email"] as? String
        
        if let picture = (dictionary["picture"] as? [String:Any])?["data"] as? [String: Any]{
            if let url = picture["url"] as? String, picture["is_silhouette"] as? Bool == false{
                self.pictureUrl = URL(string: url)
            }
        }
    }
    
}

public struct FacebookFriend {
    
    public let id: String
    public let name: String
    public var pictureUrl: URL?
    
    init(_ dictionary: [String: Any]){
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        
        if let picture = (dictionary["picture"] as? [String:Any])?["data"] as? [String: Any]{
            if let url = picture["url"] as? String, picture["is_silhouette"] as? Bool == false{
                self.pictureUrl = URL(string: url)
            }
        }
    }
    
}

public class Facebook
{
    public static var isLoggedIn : Bool {
        return AccessToken.current != nil && AccessToken.current?.expirationDate.timeIntervalSinceNow > 0
    }
    
    public static var accessToken : String? {
        return AccessToken.current?.tokenString
    }
    
    public static var userId: String? {
        return AccessToken.current?.userID
    }
    
    public static func login(permissions: [Permission] = [Permission.publicProfile]) -> Promise<AccessToken>
    {
        return Promise{ seal in
            if isLoggedIn{
                seal.fulfill(AccessToken.current!)
                return
            }

            guard let viewController = topMostViewController() else {
                seal.reject(FacebookError.unknown)
                return
            }

            let loginManager = LoginManager()
            loginManager.logIn(permissions: permissions, viewController: viewController, completion: { (loginResult) in
                switch loginResult {
                case .failed(_):
                    seal.reject(FacebookError.failed)
                case .cancelled:
                    seal.reject(FacebookError.cancelled)
                case .success(granted: _, declined: _, let accessToken):
                    if let accessToken = accessToken {
                        seal.fulfill(accessToken)
                    } else {
                        seal.reject(FacebookError.failed)
                    }
                }
            })
        }
    }
    
    
    public static func getInstalledFriends() -> Promise<[FacebookFriend]> {
        if !isLoggedIn{
            return Promise(error: FacebookError.notLoggedIn)
        }
        
        return Promise<[FacebookFriend]> { seal in
            let graphRequest = GraphRequest(graphPath: "/me/friends", parameters: ["fields": "id,name,picture.width(250).height(250)", "limit": 5000])
            graphRequest.start(completionHandler: { (connection, result, error) in
                if let error = error {
                    seal.reject(error)
                }
                else if let result = result as? [String: Any]{
                    let friends = result["data"] as? [[String:Any]] ?? []
                    seal.fulfill(friends.map{ FacebookFriend($0)})
                }
                else {
                    seal.reject(FacebookError.unknown)
                }
            })
        }
    }
    
    public static func getProfile() -> Promise<FacebookProfile> {
        if !isLoggedIn{
            return Promise(error: FacebookError.notLoggedIn)
        }
        
        return Promise { seal in
            let graphRequest = GraphRequest(graphPath: "/me", parameters: ["fields": "id,email,name,picture.width(250).height(250)"])
            graphRequest.start(completionHandler: { (connection, result, error) in
                if let error = error {
                    seal.reject(error)
                }
                else if let result = result as? [String: Any]{
                    seal.fulfill(FacebookProfile(result))
                }
                else {
                    seal.reject(FacebookError.unknown)
                }
            })
        }
    }
    
    public static func roster() -> Promise<String> {
        return Promise { seal in
            _ = getInstalledFriends()
                .done({ friends in
                    let roster = friends.map{ $0.id }.joined(separator: ",")
                    seal.fulfill(roster)
                })
        }
    }
    
    public static func logout() {
        LoginManager().logOut()
    }
}




