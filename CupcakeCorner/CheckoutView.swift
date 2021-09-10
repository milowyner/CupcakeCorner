//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Milo Wyner on 8/16/21.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var wrapper: OrderWrapper
    
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                    .accessibility(hidden: true)
                
                Text("Your total is $\(wrapper.order.cost, specifier: "%.2f")")
                    .font(.title)
                
                Button("Place Order", action: placeOrder)
                .padding()
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation, content: {
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage))
        })
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(wrapper.order) else {
            print("Failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                confirmationTitle = "Uh oh!"
                confirmationMessage = "Can't order cupcakes. \(error?.localizedDescription ?? "Unkown error.")"
                showingConfirmation = true
                return
            }
            
            guard let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
                confirmationTitle = "Uh oh!"
                confirmationMessage = "There was a problem with ordering cupcakes. Invalid response from server."
                showingConfirmation = true
                return
            }
            
            confirmationTitle = "Thank you!"
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(wrapper: OrderWrapper())
    }
}
