//
//  TextView.swift
//  Issue196
//
//  Created by Steven Harris on 3/26/24.
//

import SwiftUI

/// The TextView displays the raw html of the MarkupWKWebView.
struct TextView: UIViewRepresentable {
    @Binding var text: NSAttributedString
    var isEditable: Bool = true

    func makeUIView(context: Context) -> UITextView {
        let textView = UIViewType()
        textView.isEditable = isEditable
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.backgroundColor = UIColor.systemBackground
        uiView.attributedText = text
        uiView.spellCheckingType = .no
        uiView.autocorrectionType = .no
    }
}

