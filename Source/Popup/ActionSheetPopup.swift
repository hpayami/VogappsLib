//
//  ActionSheet.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 09/12/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import UIKit

open class ActionSheetPopup: Popup {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override open func configure() {
        super.configure()
        self.presentDuration = 0.25
        self.dismissDuration = 0.25
        self.backgroundType = .color(UIColor(rgba: "#00000070"))
        self.presentAnimation = .slideUp
        self.dismissAnimation = .slideDown
        self.backgroundPresentAnimation = .fadeIn
        self.backgroundDismissAnimation = .fadeOut
        self.minEdgesInContainer = UIEdgeInsets.init(top: 0, left: 8, bottom: 8, right: 8)
        self.presentationStyle = .actionSheet(autoDimension: false)
        self.autoAdjustsForKeyboard = false
        self.hidesStatusBarOnPresentation = true
    }
    
}

