//
//  UIFont.swift
//  Pods
//
//  Created by Ogan Topkaya on 11/11/2016.
//
//

import Foundation
import UIKit

public extension UIFont {    
    func withTraits(traits:UIFontDescriptor.SymbolicTraits...) -> UIFont {
        if let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptor.SymbolicTraits(traits)){
            return UIFont(descriptor: descriptor, size: 0)
        }
        return self
    }
}
