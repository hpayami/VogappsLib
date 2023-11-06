//
//  UITableView.swift
//  Pods
//
//  Created by Ogan Topkaya on 05/11/2016.
//
//

import Foundation
import UIKit
import PureLayout

public extension UITableView{

    func addLoadingIndicatorToFooter(){
        let activityContainer = UIView(frame: CGRect(x: 0,y: 0,width: 320,height: 26))
        activityContainer.backgroundColor = UIColor.clear
        
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.startAnimating()
        activityContainer.addSubview(activityIndicator)
        activityIndicator.autoCenterInSuperview()
        activityIndicator.autoSetDimensions(to: CGSize(width: 20, height: 20))
        self.tableFooterView = activityContainer
    }
    
    func removeLoadingIndicatorFromFooter(){
        self.tableFooterView = UIView()
    }

}
