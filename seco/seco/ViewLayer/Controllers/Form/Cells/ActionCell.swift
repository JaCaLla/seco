//
//  ActionCell.swift
//  seco
//
//  Created by Javier Calatrava on 11/04/2020.
//  Copyright © 2020 Javier Calatrava. All rights reserved.
//

import SwiftUI

struct ActionCell: View {
    var onAction: () -> Void = { /* Default empty block */}
    var body: some View {
        Button(action: {
            self.onAction()
        }, label: {
            Text("OK")
        })
    }
}

struct ActionCell_Previews: PreviewProvider {
    static var previews: some View {
        ActionCell()
    }
}
