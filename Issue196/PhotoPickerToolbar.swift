//
//  PhotoPickerToolbar.swift
//  Issue196
//
//  Created by Steven Harris on 3/26/24.
//

import SwiftUI
import MarkupEditor
import PhotosUI

/// The toolbar to open new or existing files and to expose the raw HTML in the selectedWebView.
struct PhotoPickerToolbar: View {
    @State private var hoverLabel: Text = Text("File")
    @State private var showPhotosPicker: Bool = false
    @State private var selectedItem: PhotosPickerItem?
    private var photoPickerDelegate: PhotoPickerDelegate?
    
    var body: some View {
        LabeledToolbar(label: hoverLabel) {
            ToolbarImageButton(
                systemName: "plus",
                action: { photoPickerDelegate?.newDocument(handler: nil) },
                onHover: { over in hoverLabel = Text(over ? "New" : "File") }
            )
            PhotosPicker(selection: $selectedItem, matching: .images) {
                Image(systemName: "photo")
            }
            .buttonStyle(.borderless)
            .contentShape(Rectangle())
            .onChange(of: selectedItem) { item in
                photoPickerDelegate?.selectedPhotosItem(item)
            }
            ToolbarImageButton(
                systemName: "chevron.left.slash.chevron.right",
                action: { photoPickerDelegate?.rawDocument() },
                onHover: { over in hoverLabel = Text(over ? "Raw HTML" : "File") }
            )
        }
    }

    init(photoPickerDelegate: PhotoPickerDelegate? = nil) {
        self.photoPickerDelegate = photoPickerDelegate
    }
    
}

