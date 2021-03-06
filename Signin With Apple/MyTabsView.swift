//
//  MyTabsView.swift
//  MyAppsTasksCD
//
//  Created by Stewart Lynch on 10/28/19.
//  Copyright © 2019 Stewart Lynch. All rights reserved.
//

import SwiftUI

struct MyTabsView: View {
    @EnvironmentObject var userInfo:UserInfo
    var body: some View {
        ZStack {
            if userInfo.isUserAuthenticated == .undefined {
                Text("Loading...")
            } else if userInfo.isUserAuthenticated == .signedOut {
                LoginView()
            } else if userInfo.isUserAuthenticated == .signedIn {
                TabView {
                    ContentView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                    }.tag(1)
                    Text("Let's Go Driving")
                        .tabItem {
                            Image(systemName: "car.fill")
                            Text("Travel")
                    }.tag(2)
                }
            }
        }.onAppear {
            self.userInfo.configureFirebaseStateDidChange()
        }
        
    }
}

struct MyTabsView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabsView()
    }
}
    
