//
//  CGRect.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 06/07/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import UIKit


public extension CGRect{
    func rectByApplyingInsets(_ insets: UIEdgeInsets) -> CGRect{
        return CGRect(x: self.origin.x + insets.left,
            y: self.origin.y + insets.top,
            width: self.width - insets.right - insets.left,
            height: self.height - insets.top - insets.bottom)
    }
    
    func bestSquareToFitInCenter(withPadding padding:CGFloat)-> CGRect{
        let minEdge = min(self.size.width, self.size.height)
        
        var frame = CGRect(x: self.origin.x, y: self.origin.y, width: minEdge - 2 * padding, height: minEdge - 2 * padding)
        frame.origin.x = (self.size.width - minEdge) / 2 + padding + self.origin.x
        frame.origin.y = (self.size.height - minEdge) / 2 + padding + self.origin.y
        return frame
    }
    
    func bestSquareToFitInEdges(withPadding padding:CGFloat, edge: CGRectEdge) -> CGRect{
        var frame = bestSquareToFitInCenter(withPadding: padding)
        
        switch edge{
        case .minXEdge:
            frame.origin.x = self.origin.x + padding
        case .maxXEdge:
            frame.origin.x = self.origin.x + (self.size.width - frame.size.width - padding)
        case .minYEdge:
            frame.origin.y = self.origin.y + padding
        case .maxYEdge:
            frame.origin.y = self.origin.y + (self.size.height - frame.size.height - padding)
            
        }
        
        return frame
    }
    
    func rectByDividingTo(_ slices: Int, edge: CGRectEdge, padding: CGFloat = 0) -> [CGRect]{
        var rects = [CGRect]()
        
        if (edge == .minXEdge || edge == .maxXEdge){
            let sliceWidth = self.size.width / CGFloat(slices)
            for i in 0..<slices{
                let rect = CGRect(x: (CGFloat(i) * sliceWidth) + self.origin.x, y: self.origin.y, width: sliceWidth, height: self.size.height).rectByApplyingInsets(UIEdgeInsets.init(top: 0, left: padding / 2, bottom: 0, right: padding / 2))
                rects.append(rect)
            }
        }
        else{
            let sliceHeight = self.size.height / CGFloat(slices)
            for i in 0..<slices{
                let rect = CGRect(x: self.origin.x, y: (CGFloat(i) * sliceHeight) + self.origin.y, width: self.size.width, height: sliceHeight).rectByApplyingInsets(UIEdgeInsets.init(top: padding / 2, left: 0, bottom: padding / 2, right: 0))
                rects.append(rect)
            }
        }
        
        return rects
    }
}

public func CGRectMakeWithInsets(frame: CGRect, insets: UIEdgeInsets) -> CGRect{
    return frame.rectByApplyingInsets(insets)
}
