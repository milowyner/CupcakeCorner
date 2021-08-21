//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Milo Wyner on 8/16/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var wrapper = OrderWrapper()
    
    var body: some View {
        NavigationView {
            Form {
                Group {
                    Picker("Select your cake type", selection: $wrapper.order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $wrapper.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(wrapper.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $wrapper.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if wrapper.order.specialRequestEnabled {
                        Toggle(isOn: $wrapper.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $wrapper.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(wrapper: wrapper)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
