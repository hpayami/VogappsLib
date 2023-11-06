//
//  UIImage.swift
//  VogappsLib
//
//  Created by Ogan on 28/07/15.
//  Copyright © 2015 Vogapps. All rights reserved.
//

import UIKit
import PromiseKit
import ImageIO

public extension UIImage{
    convenience init(color: UIColor){
        let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.init(cgImage: image.cgImage!)
    }
    
    func copyToDocuments(metadata: [String: Any]? = nil) -> Promise<URL> {
        let localPath = URL(fileURLWithPath: documentsDirectory).appendingPathComponent(UUID().uuidString).appendingPathExtension("jpeg")
        return copyToPath(path: localPath, metadata: metadata)
    }
    
    func copyToPath(path: URL,metadata: [String: Any]? = nil) -> Promise<URL> {
        let data = self.fixOrientation().jpegData(compressionQuality: 1)!
        
        guard let source = CGImageSourceCreateWithData(data as CFData, nil),
            let uniformTypeIdentifier = CGImageSourceGetType(source) else { return Promise(error : NSError())}
        let imageData = NSMutableData(data: data)
        
        if let metadata = metadata {
            guard let destination = CGImageDestinationCreateWithData(imageData, uniformTypeIdentifier, 1, nil) else { return Promise(error: NSError())}
            
            CGImageDestinationAddImageFromSource(destination, source, 0, metadata as CFDictionary?)
            guard CGImageDestinationFinalize(destination) else { return Promise(error: NSError())}
        }
        try? imageData.write(to: path, options: [])
        return .value(path)
    }
    
}
