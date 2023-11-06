//
//  Global.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 06/07/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import Foundation

public let documentsDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!

public func delay(_ delay:Double, closure:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

public func radians<T: FloatingPoint>(_ angle:T) -> T{
    return angle * T.pi / 180
}

/*! Interpolarates values between min&max
When min = 10 , max = 20 , value = 0.5 => result = 15
*/
public func lerp<T: FloatingPoint>(_ min: T, _ max: T, _ value: T) -> T {
    return (1-value)*min + value*max;
}

/*! Inverse calculation of lerp
When min = 10 , max = 20 , value = 15 => result = 0.5
*/
public func inverseLerp<T: FloatingPoint>(_ min: T,_ max: T,_ value: T) -> T{
    return (value - min) / (max - min);
}

public func totalDiskSpaceMB() -> (freeSpace: Double, totalSpace: Double) {
    let attributes = try? FileManager.default.attributesOfFileSystem(forPath: documentsDirectory)
    if let totalSpace = attributes?[FileAttributeKey.systemSize] as? Double,
        let freeSpace = attributes?[FileAttributeKey.systemFreeSize] as? Double{
        return (freeSpace: freeSpace/1024/1024, totalSpace: totalSpace/1024/1024)
    }
    
    return (freeSpace: 0, totalSpace: 0)
}

public func totalDiskSpaceGB() -> (freeSpace: Double, totalSpace: Double){
    let result = totalDiskSpaceMB()
    return (freeSpace: result.freeSpace/1024, totalSpace: result.totalSpace/1024)
}

public func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

public func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}


