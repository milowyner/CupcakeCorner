//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Milo Wyner on 8/16/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var wrapper: OrderWrapper
    
    var body: some View {
        Form {
            Group {
                TextField("Name", text: $wrapper.order.name)
                TextField("Street Address", text: $wrapper.order.streetAddress)
                TextField("City", text: $wrapper.order.city)
                TextField("Zip", text: $wrapper.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(wrapper: wrapper)) {
                    Text("Check out")
                }
                .disabled(!wrapper.order.hasValidAddress)
            }
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(wrapper: OrderWrapper())
    }
}
