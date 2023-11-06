//
//  StackView.swift
//  Vogapps
//
//  Created by Ogan Topkaya on 22/09/2016.
//  Copyright © 2016 Vogapps. All rights reserved.
//

import Foundation
import PureLayout

public extension UIStackView{
    
    func removeSeparators(){
        self.findSubviews(ofKind: UIStackViewSeparatorView.self)?.forEach{$0.removeFromSuperview()}
    }
    
    func addSeparator(color: UIColor? = nil, inset: CGFloat? = nil, size: CGFloat? = nil){
        let separatorView = UIStackViewSeparatorView()
        
        if let color = color {
            separatorView.backgroundColor = color
        }
        
        self.addArrangedSubview(separatorView)
        
        if let inset = inset {
            if self.axis == .horizontal {
                separatorView.autoPinEdge(toSuperviewEdge: .top, withInset: inset, relation: NSLayoutConstraint.Relation.equal)
                separatorView.autoPinEdge(toSuperviewEdge: .bottom, withInset: inset, relation: NSLayoutConstraint.Relation.equal)
            }
            else {
                separatorView.autoPinEdge(toSuperviewEdge: .leading, withInset: inset, relation: NSLayoutConstraint.Relation.equal)
                separatorView.autoPinEdge(toSuperviewEdge: .trailing, withInset: inset, relation: NSLayoutConstraint.Relation.equal)
            }
        }
        
        if let size = size {
            if self.axis == .horizontal {
                separatorView.autoSetDimension(.height, toSize: size)
            }
            else {
                separatorView.autoSetDimension(.width, toSize: size)
            }
        }
        
    }
    
    func addSeparator(after view: UIView, color: UIColor? = nil, inset: CGFloat? = nil, size: CGFloat? = nil){
        if let i = self.arrangedSubviews.firstIndex(of: view) {
            let index = Int(i)
            
            if self.arrangedSubviews.count - 2 == index {
                return
            }
            self.addSeparator(to: index + 1, color: color, inset: inset, size: size)
        }
    }
    
    func addSeparator(to index: Int, color: UIColor? = nil, inset: CGFloat? = nil, size: CGFloat? = nil){
        let separatorView = UIStackViewSeparatorView()
        if let color = color {
            separatorView.backgroundColor = color
        }
        
        self.insertArrangedSubview(separatorView, at: index)
        
        if let inset = inset {
            if self.axis == .horizontal {
                separatorView.autoPinEdge(toSuperviewEdge: .top, withInset: inset, relation: NSLayoutConstraint.Relation.equal)
                separatorView.autoPinEdge(toSuperviewEdge: .bottom, withInset: inset, relation: NSLayoutConstraint.Relation.equal)
            }
            else {
                separatorView.autoPinEdge(toSuperviewEdge: .leading, withInset: inset, relation: NSLayoutConstraint.Relation.equal)
                separatorView.autoPinEdge(toSuperviewEdge: .trailing, withInset: inset, relation: NSLayoutConstraint.Relation.equal)
            }
        }
        
        if let size = size {
            if self.axis == .horizontal {
                separatorView.autoSetDimension(.height, toSize: size)
            }
            else {
                separatorView.autoSetDimension(.width, toSize: size)
            }
        }
        
    }
    
    
}


open class UIStackViewSeparatorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    func configure(){
        self.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
    }
    
    override open var intrinsicContentSize: CGSize{
        return CGSize(width: 1, height: 1)
    }
    
}

