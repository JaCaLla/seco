//
//  MultilineInputCell.swift
//  seco
//
//  Created by Javier Calatrava on 13/04/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import SwiftUI
import UIKit

private struct MultilineInputCell: UIViewRepresentable {
    @Binding var value: String
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = value
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineInputCell

        init(_ multilineInputCell: MultilineInputCell) {
            self.parent = multilineInputCell
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.value = textView.text
        }
    }
}

struct MultilineInputTextView : View {
    var text:String = ""
     @Binding var value: String
    
    init(text: String, value: Binding<String>) {
        self.text  = text
        self._value = value
      }

    var body: some View {
        VStack{
            HStack {
                Text("\(text)")
                Spacer()
            }
            MultilineInputCell(value: $value)
            .frame(height: 100)
            .bordered()
        }.padding(.horizontal)
    }
}
