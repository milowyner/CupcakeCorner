//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Milo Wyner on 8/16/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
