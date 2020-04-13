//
//  BordererViewModifier.swift
//  seco
//
//  Created by Javier Calatrava on 11/04/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import SwiftUI

struct BordererViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 2)
                .foregroundColor(.gray))
            .shadow(color: .gray,
                    radius: 3, x: 1, y: 2)
    }
}

extension View {
    func bordered() -> some View {
        ModifiedContent(content: self, modifier: BordererViewModifier())
    }
}

