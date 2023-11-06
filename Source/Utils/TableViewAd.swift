//
//  TableViewAd.swift
//  Pods
//
//  Created by Ogan Topkaya on 21/06/2017.
//
//

import Foundation

public class TableViewAd {
    
    public static func isAdCellAt(index: Int, itemCount: Int, adCount: Int, forStride stride:Int) -> Bool {
        if itemCount <= 0 || adCount <= 0 || stride <= 0 || index <= 0 {
            return false
        }
        
        let maxAdCount : Int = min(min(max(1, itemCount / stride), adCount),itemCount)
        
        return (itemCount < stride && index == itemCount + maxAdCount - 1) ||
            (((index + 1) % (stride + 1) == 0 && index/(stride + 1) < maxAdCount))
    }
    
    public static func adjustNonAdCell(index: Int, itemCount: Int, adCount: Int, forStride stride:Int) -> Int? {
        if itemCount == 0 {
            return nil
        }
        
        if index == 0 && itemCount == 0 {
            return nil
        }

        if isAdCellAt(index: index, itemCount: itemCount, adCount: adCount, forStride: stride) {
            return nil
        }
        
        if index >= adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) {
            return nil
        }
        
        let addedAd = min(adCount , index / (stride + 1))
        return index - addedAd
    }
    
    public static func adjustAdCell(index: Int, itemCount: Int, adCount: Int, forStride stride:Int) -> Int? {
        if itemCount == 0 {
            return nil
        }
        
        if index == 0 && itemCount == 0 {
            return nil
        }
        
        if !isAdCellAt(index: index, itemCount: itemCount, adCount: adCount, forStride: stride) {
            return nil
        }
        
        if index >= adjustCount(itemCount: itemCount, adCount: adCount, forStride: stride) {
            return nil
        }
        
        let addedAd = min(adCount , index / (stride + 1))
        return addedAd
    }
    
    public static func adjustCount(itemCount: Int, adCount: Int,forStride stride: Int) -> Int {
        if stride == 0 {
            return itemCount
        }
        
        if itemCount == 0 {
            return 0
        }
        
        let maxAdCount : Int = max(1, itemCount / stride)
        return itemCount + min(min(maxAdCount, adCount),itemCount)
    }

}

