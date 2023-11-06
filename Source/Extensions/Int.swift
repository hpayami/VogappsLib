//
//  Int.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 06/07/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import Foundation

public extension Int{
    func times(_ task: (Int)->()){
        for i in 0..<self{
            task(i)
        }
    }

    func abbreviatedString() -> String {
        var ret: String = ""
        let abbrve: [String] = ["K", "M", "B"]
        
        let floatNum = Float(self)
        
        if floatNum > 10000 {
            
            for i in 0..<abbrve.count {
                let size = pow(10.0, (Float(i) + 1.0) * 3.0)
                if (size <= floatNum) {
                    let num = floatNum / size
                    let str = floatToString(num)
                    ret = "\(str)\(abbrve[i])"
                }
            }
        } else {
            ret = floatToString(floatNum)
        }
        
        return ret
    }
}

public extension Comparable {
    func clamp(_ min: Self, _ max: Self) -> Self {
        return Swift.max(min, Swift.min(max, self))
    }
}


private let decimalFormatter : NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 1
    return formatter
}()

private func floatToString(_ val: Float) -> String {
    return decimalFormatter.string(from: NSNumber(value: val)) ?? ""
}


