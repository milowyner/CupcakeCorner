//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Milo Wyner on 8/16/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
