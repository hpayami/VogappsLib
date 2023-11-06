//
//  Dictionary.swift
//  Pods
//
//  Created by Ogan Topkaya on 01/08/2017.
//
//

import Foundation

public extension Dictionary where Key: Comparable, Value: Equatable {
    func minus(dict: [Key:Value]) -> [Key:Value] {
        let entriesInSelfAndNotInDict = filter { dict[$0.0] != self[$0.0] }
        return entriesInSelfAndNotInDict.reduce([Key:Value]()) { (res, entry) -> [Key:Value] in
            var res = res
            res[entry.0] = entry.1
            return res
        }
    }
}
