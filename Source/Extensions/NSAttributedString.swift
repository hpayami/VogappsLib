//
//  NSAttributedString.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 18/12/15.
//
//

import Foundation

public extension NSMutableAttributedString{

    @discardableResult
    func appendString(_ string: String, font: UIFont, color: UIColor) -> NSMutableAttributedString {
        self.append(NSAttributedString(string: string,
                                       attributes: [NSAttributedString.Key.font : font, NSAttributedString.Key.foregroundColor : color]))
        return self
    }
    
    @discardableResult
    func lineSpacing(_ lineSpacing: CGFloat, range: NSRange) -> NSMutableAttributedString{
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        self.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        return self
    }
    
    @discardableResult
    func lineSpacing(_ lineSpacing: CGFloat) -> NSMutableAttributedString{
        return self.lineSpacing(lineSpacing, range: NSMakeRange(0, self.length))
    }
    
    func trimCharacters(in characterSet: CharacterSet) {
        var range = (string as NSString).rangeOfCharacter(from: characterSet)
        
        // Trim leading characters from character set.
        while range.length != 0 && range.location == 0 {
            replaceCharacters(in: range, with: "")
            range = (string as NSString).rangeOfCharacter(from: characterSet)
        }
        
        // Trim trailing characters from character set.
        range = (string as NSString).rangeOfCharacter(from: characterSet, options: .backwards)
        while range.length != 0 && NSMaxRange(range) == length {
            replaceCharacters(in: range, with: "")
            range = (string as NSString).rangeOfCharacter(from: characterSet, options: .backwards)
        }
    }

}

public extension NSAttributedString {
    func trimmingCharacters(in characterSet: CharacterSet) -> NSAttributedString {
        let modifiedString = NSMutableAttributedString(attributedString: self)
        modifiedString.trimCharacters(in: characterSet)
        return NSAttributedString(attributedString: modifiedString)
    }
}

