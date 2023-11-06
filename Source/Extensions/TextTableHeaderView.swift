
//
//  TextTableHeaderView.swift
//  Giftfeed
//
//  Created by Ogan Topkaya on 12/02/16.
//  Copyright © 2016 Vogapps. All rights reserved.
//

import Foundation

public extension UITableView{
    
    @discardableResult
    func setTextHeader(_ text: String?, font: UIFont = UIFont.systemFont(ofSize: 14)) -> TextTableHeaderView?{
        guard let text = text else {
            self.tableHeaderView = nil
            return nil
        }
        
        let width = UIScreen.main.bounds.size.width
        
        let headerView = TextTableHeaderView(frame: CGRect(x: 0,y: 0,width: 50, height: 50))
        headerView.titleLabel.font = font
        headerView.titleLabel.text = text
        headerView.backgroundColor = UIColor.clear
        headerView.frame = CGRect(x: 0, y: 0, width: width, height: headerView.intrinsicHeightForWidth(width))
        
        self.tableHeaderView = headerView
        return headerView
    }
    
    @discardableResult
    func setTextFooter(_ text: String?) -> TextTableHeaderView?{
        guard let text = text else {
            self.tableHeaderView = nil
            return nil
        }
        
        let width = UIScreen.main.bounds.size.width
        
        let headerView = TextTableHeaderView(frame: CGRect(x: 0,y: 0,width: 50, height: 50))
        headerView.titleLabel.text = text
        headerView.titleLabel.textColor = UIColor(rgba: "#999999")
        headerView.titleLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
        headerView.backgroundColor = UIColor.clear
        headerView.frame = CGRect(x: 0, y: 0, width: width, height: headerView.intrinsicHeightForWidth(width))
        
        self.tableFooterView = headerView
        return headerView
    }
    
}

open class TextTableHeaderView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    open lazy var titleLabel : UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor(rgba: "#4a4a4a")
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = UIColor.clear
        self.addSubview(label)
        label.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets.init(top: 10, left: 30, bottom: 10, right: 30))
        return label
    }()
    
    func configure(){
        self.backgroundColor = UIColor.white
    }
    
    func intrinsicHeightForWidth(_ width: CGFloat) -> CGFloat{
        let textSize = (self.titleLabel.text! as NSString).boundingRect(with: CGSize(width: width - 60,height: 10000), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: titleLabel.font!], context: nil)
        return textSize.height + 22
    }
    
}

