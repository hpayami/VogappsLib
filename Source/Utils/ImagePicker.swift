//
//  ImagePicker.swift
//  VogappsLib
//
//  Created by Ogan Topkaya on 17/11/16.
//  Copyright © 2016 Vogapps. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit
import MobileCoreServices

public typealias UIImagePickerResult = (image: UIImage, metadata: [String: Any], dateTaken: Date)

open class ImagePicker{
    static public func selectSourceAndPickImage(
        actionSheetTitle title: String? = nil,
        actionSheetMessage message: String? = nil,
        sourceTypes: [UIImagePickerController.SourceType] = [.camera, .photoLibrary, .savedPhotosAlbum],
        allowsEditing: Bool = true) -> Promise<UIImagePickerResult>{
        
        return ImagePicker.askSource(actionSheetTitle: title, actionSheetMessage: message, sourceTypes: sourceTypes)
            .then{ source -> Promise<UIImagePickerResult> in
                return ImagePicker.pickImage(sourceType: source, allowsEditing: allowsEditing)
            }
    }
    
    static public func askSource(
        actionSheetTitle title: String? = nil,
        actionSheetMessage message: String? = nil,
        sourceTypes: [UIImagePickerController.SourceType] = [.camera, .photoLibrary, .savedPhotosAlbum]
        ) -> Promise<UIImagePickerController.SourceType>{
        
        return Promise {seal in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) && sourceTypes.contains(.camera){
                alertController.addAction(UIAlertAction.init(title: NSLocalizedString("Take Photo", comment: ""), style: .default, handler: { _ in
                    seal.fulfill(.camera)
                }))
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) && sourceTypes.contains(.photoLibrary){
                alertController.addAction(UIAlertAction.init(title: NSLocalizedString("Photo Library", comment: ""), style: .default, handler: { _ in
                    seal.fulfill(.photoLibrary)
                }))
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) && sourceTypes.contains(.savedPhotosAlbum){
                alertController.addAction(UIAlertAction.init(title: NSLocalizedString("Saved Photos", comment: ""), style: .default, handler: { _ in
                    seal.fulfill(.savedPhotosAlbum)
                }))
            }
            alertController.addAction(UIAlertAction.init(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { _ in
                seal.reject(PMKError.cancelled)
            }))
            topMostViewController()!.present(alertController, animated: true)
        }
    }
    
    static public func pickImage(sourceType type: UIImagePickerController.SourceType,
                        allowsEditing: Bool = true) -> Promise<UIImagePickerResult>{
        
        return ImagePickerControllerProxy().pickImage(sourceType: type, allowsEditing: allowsEditing)
    }
}


class ImagePickerControllerProxy: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    fileprivate let (promise, seal) = Promise<UIImagePickerResult>.pending()
    fileprivate var retainCycle: ImagePickerControllerProxy?
    
    func pickImage(sourceType type: UIImagePickerController.SourceType, allowsEditing: Bool = true) -> Promise<UIImagePickerResult> {
        
        self.retainCycle = self
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.allowsEditing = allowsEditing
        picker.delegate = self
        picker.mediaTypes = [kUTTypeImage as String]
        topMostViewController()!.present(picker, animated: true, completion: nil)
        return self.promise
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        
        var image : UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            image = editedImage
        }
        else {
            image = info[.originalImage] as? UIImage
        }
        
        if let image = image{
            seal.fulfill((image, [:], Date()))
        }
        else {
            self.seal.reject(NSError(domain: "ImagePickerController", code: 1, userInfo: nil))
        }
        
        self.retainCycle = nil
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.seal.reject(NSError(domain: "ImagePickerController", code: 1, userInfo: nil))
        self.retainCycle = nil
        picker.dismiss(animated: true, completion: nil)
    }
    
}
