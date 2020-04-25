//
//  ContentView.swift
//  GetCloser4iOS
//
//  Created by gridscale on 2020/04/25.
//  Copyright © 2020 gridscale. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            Text("井戸端会議")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("Near")
                        Text("井戸端")
                    }
                }
                .tag(0)
            Text("サービスエリア")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("Service")
                        Text("サービス")
                    }
                }
                .tag(1)
            Text("Social Network")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("Network")
                        Text("SNS")
                    }
                }
                .tag(2)
            Text("Profile")
                .font(.title)
                .tabItem {
                    VStack {
                        Image("Profile")
                        Text("Profile")
                    }
                }
                .tag(3)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
