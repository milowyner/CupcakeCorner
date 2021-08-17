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
        ScrollView {
            VStack {
                Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                
                Text("Your total is $\(order.cost, specifier: "%.2f")")
                    .font(.title)
                
                Button("Place order") {
                    // place the order
                }
                .padding()
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
