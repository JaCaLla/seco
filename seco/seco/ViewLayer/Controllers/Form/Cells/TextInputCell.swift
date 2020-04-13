//
//  TextInputCell.swift
//  seco
//
//  Created by Javier Calatrava on 11/04/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.


import SwiftUI

struct TextInputCell: View {
    var text: String
    @Binding var value: String
    
 init(text: String, value: Binding<String>) {
      self.text  = text
      self._value = value
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(text)")
                Spacer()
            }
            TextField("placeholder", text: $value).bordered()
        }.padding()
        
    }
}

struct TextInputCell_Previews: PreviewProvider {
    static var previews: some View {
        TextInputCell(text: "Name:", value: .constant(""))
    }
}
