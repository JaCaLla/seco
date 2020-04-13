//
//  DateSelectorCell.swift
//  seco
//
//  Created by Javier Calatrava on 11/04/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import SwiftUI

struct DateSelectorCell: View {
    var text: String
    @Binding var date: Date
    
    init(text: String, value: Binding<Date>) {
         self.text  = text
         self._date = value
       }
    
    var body: some View {
        VStack {
            HStack {
                 Text("Select Date")
                Spacer()
            }
            DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                Text("")
            }.bordered()
        }.padding()
    }
}

struct DateSelectorCell_Previews: PreviewProvider {
    static var previews: some View {
        DateSelectorCell(text: "timestamp",value: .constant(Date()))
    }
}
