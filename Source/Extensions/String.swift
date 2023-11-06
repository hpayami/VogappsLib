//
//  String.swift
//  Pods
//
//  Created by Ogan Topkaya on 21/03/16.
//
//

import Foundation

public extension String {
    var firstLetter : String {
        guard let firstChar = self.first
            else
        {
            return ""  // If title is nil return empty string
        }
        return String(firstChar)
    }
    
    func capturedGroups(withRegex pattern: String) -> [String] {
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return []
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.count))
        
        guard let match = matches.first else { return [] }
        
        // Note: Index 1 is 1st capture group, 2 is 2nd, ..., while index 0 is full match which we don't use
        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return [] }
        
        var results = [String]()
        
        for i in 1...lastRangeIndex {
            let capturedGroupIndex = match.range(at: i)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            results.append(matchedString)
        }
        
        return results
    }
    
    func truncatedString(maxLength: Int, truncationToken: String = "...") -> String {
        if maxLength > 0 && self.count > maxLength && truncationToken.count < maxLength {
            return self[self.startIndex..<self.index(self.startIndex, offsetBy: maxLength - truncationToken.count)] + truncationToken
        }
        else {
            return self
        }
    }
    
    func hideLastName() -> String {
        return Utilities.hideTheLastName(self)
    }
    
    
    func replaceCharactersFromSet(characterSet: CharacterSet, replacementString: String = "") -> String {
        return self.components(separatedBy: characterSet).joined(separator: replacementString)
    }
    
    func slice(from: String, to: String) -> String? {
        
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
}
