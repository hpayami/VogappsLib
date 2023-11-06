//
//  Array.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 21/07/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import Foundation

public extension Array{
    subscript (safe index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
    
    subscript (safe range: Range<Int>) -> ArraySlice<Element> {
        if range.lowerBound >= 0 && range.upperBound >= count{
            return self[0..<self.count]
        }
        else if range.lowerBound >= 0 && range.upperBound < count {
            return self[range]
        }
        else {
            return ArraySlice<Element>()
        }
    }
}

public extension RangeReplaceableCollection where Iterator.Element : Equatable{
    mutating func removeObject(_ object : Self.Iterator.Element) {
        while let index = self.firstIndex(of: object){
            self.remove(at: index)
        }
    }
    
    func insertObjectsWithReplacing(_ objects: [Self.Iterator.Element]) -> Self{
        var temp = self
        objects.forEach { (element) -> () in
            temp.removeObject(element)
            temp.append(element)
        }
        return temp
    }
}

public extension Collection where Iterator.Element : Equatable{
    func numberOfObjectsEqualTo(_ object : Self.Iterator.Element) -> Int{
        return self.reduce(0, { $0 + ($1 == object ? 1 : 0)})
    }
}


public extension Array where Element: Equatable {
    /// Array containing only _unique_ elements.
    var unique: [Element] {
        var result: [Element] = []
        for element in self {
            if !result.contains(element) {
                result.append(element)
            }
        }
        
        return result
    }
}
