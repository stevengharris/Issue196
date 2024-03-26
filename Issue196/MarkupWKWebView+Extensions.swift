//
//  MarkupWKWebView+Extensions.swift
//  Issue196
//
//  Created by Steven Harris on 3/26/24.
//

import MarkupEditor
import SwiftUI
import PhotosUI
import OSLog

extension MarkupWKWebView {
    
    public func insertPhotosItem(item: PhotosPickerItem, handler: ((URL?)->Void)? = nil) {
        // Make a new unique ID for the image to save in the cacheUrl directory
        var pathExtension: String
        if item.supportedContentTypes.firstIndex(of: .jpeg) != nil {
            pathExtension = "jpeg"
        } else if item.supportedContentTypes.firstIndex(of: .png) != nil {
            pathExtension = "png"
        } else {
            Logger.webview.error("Error inserting photo: Photo must be png or jpeg.")
            handler?(nil)
            return
        }
        let path = "\(UUID().uuidString).\(pathExtension)"
        // Prepend with resourcesUrl if needed
        //if let resourcesUrl {
        //    path = resourcesUrl.appendingPathComponent(path).relativePath
        //}
        let cachedImageUrl = URL(fileURLWithPath: path, relativeTo: baseUrl)
        Task {
            do {
                let data = try await item.loadTransferable(type: Data.self)
                if data != nil, let uiImage = UIImage(data: data!) {
                    if pathExtension == "jpeg" {
                        try uiImage.jpegData(compressionQuality: 1)?.write(to: cachedImageUrl)
                    } else {
                        try uiImage.pngData()?.write(to: cachedImageUrl)
                    }
                    insertImage(src: path, alt: nil) {
                        handler?(cachedImageUrl)
                    }
                }
            } catch let error {
                Logger.webview.error("Error inserting local image: \(error.localizedDescription)")
                handler?(nil)
            }
        }
    }
    
}
