//
//  AppView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 05/09/2023.
//

import SwiftUI

struct AppView: View {
    @EnvironmentObject var storageObject : StorageObject
    @EnvironmentObject var userDetailStorage : UserHistory
    @State private var presentingSignUpView = true
    var body: some View {
        ZStack {
            TabView {
                //display the feature view
                FrontView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                            .foregroundColor(.blue)
                    }
    //                .toolbarBackground(theme.primaryColor, for: .tabBar)
                
                //display the list view
                StatTabBarView(user: userDetailStorage.getCurrentUser() ?? user1)

                    .tabItem {
                        Label("Your Record", systemImage: "person.crop.circle.fill")
                    }
                    .toolbarBackground(.black, for: .tabBar)
                
                TopUserView()
                    .tabItem {
                        Label("Leaderboard", systemImage: "person.3.sequence.fill")
                    }
                    .toolbarBackground(.black, for: .tabBar)
                
                
               
            }
            if(presentingSignUpView){
                UserSignUpView(presentingSignUp: $presentingSignUpView)
            }
        }
        .preferredColorScheme(storageObject.theme ? .light : .dark)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
            .environmentObject(StorageObject())
            .environmentObject(SoundDataStorage())
            .environmentObject(UserHistory())
    }
}


