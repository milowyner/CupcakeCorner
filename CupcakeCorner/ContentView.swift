//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Milo Wyner on 8/16/21.
//

import SwiftUI

class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
        case number
    }
    
    @Published var name = "Paul Hudson"
    @Published var number = 5
    
    init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        number = try container.decode(Int.self, forKey: .number)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(number, forKey: .number)
    }
}

struct OtherView: View {
    @ObservedObject var user: User
    @State private var name: String = ""
    @State private var number: String = ""
    
    var body: some View {
        Text(user.name)
        Text(String(user.number))
        TextField("New name", text: $name, onCommit:  {
            user.name = name
            ContentView.encode(user: user)
        })
        TextField("New number", text: $number, onCommit:  {
            if let number = Int(number) {
                user.number = number
                ContentView.encode(user: user)
            }
        })
    }
}

struct ContentView: View {
    @ObservedObject private var user: User = Self.decode()
    
    @State private var showingSheet = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text(user.name)
            Text(String(user.number))
            Button("Show sheet") {
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet, content: {
            OtherView(user: user)
        })
//        .onAppear(perform: {
//            UserDefaults.standard.removeObject(forKey: "user")
//        })
    }
    
    static func encode(user: User) {
        guard let data = try? JSONEncoder().encode(user) else {
            fatalError("Failed to encode")}
        
        UserDefaults.standard.setValue(data, forKey: "user")
    }
    
    static func decode() -> User {
        guard let data = UserDefaults.standard.data(forKey: "user"),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            print("fail")
            return User()
        }
        
        return user
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
