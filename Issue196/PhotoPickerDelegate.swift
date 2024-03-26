//
//  PhotoPickerDelegate.swift
//  Issue196
//
//  Created by Steven Harris on 3/26/24.
//

import SwiftUI
import PhotosUI

/// The FileToolbarDelegate handles requests from the FileToolbar.
@MainActor
protocol PhotoPickerDelegate {
    func newDocument(handler: ((URL?)->Void)?)
    func existingDocument(handler: ((URL?)->Void)?)
    func selectedPhotosItem(_ item: PhotosPickerItem?)
    func rawDocument()
}

