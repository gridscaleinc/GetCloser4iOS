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
            NavigationView {
                PlaceView()
                .navigationBarTitle(Text("Near by me"))
            }.tabItem {
                VStack {
                     Image("Near")
                     Text("井戸端")
                }
            }.tag(0)
            NavigationView {
                Text("サービスエリア")
                    .font(.title)
                .navigationBarTitle(Text("Service Area"))
            }
            .tabItem {
                VStack {
                    Image("Service")
                    Text("サービス")
                }
            }
            .tag(1)
            NavigationView {
                Text("Social Network")
                    .font(.title)
                .navigationBarTitle(Text("Social Network"))
            }
            .tabItem {
                VStack {
                    Image("Network")
                    Text("SNS")
                }
            }
            .tag(2)
            NavigationView {
            Text("Profile")
                .font(.title)
                .navigationBarTitle(Text("Profile"))
            }
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
