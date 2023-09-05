/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 1
 Author: Dinh Gia Huu Phuoc
 ID: s3878270
 Created  date: 25/08/2023
 Last modified: 06/09/2023
 Acknowledgement: COSC2659 Lecture Slides, Apple IOS Development Tutorial
 */

import SwiftUI

struct AppView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var storageObject : StorageObject
    @EnvironmentObject var soundStorage : SoundDataStorage
    @EnvironmentObject var userDetailStorage : UserHistory
    @State private var presentingSignUpView = true
    var body: some View {
        ZStack {
            TabView {
                //display the feature view
                FrontView(isPresentingSignUpView: $presentingSignUpView)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
                //display the list view
                StatTabBarView(user: userDetailStorage.getCurrentUser() ?? user1)

                    .tabItem {
                        Label("Your Record", systemImage: "person.crop.circle.fill")
                    }
                
                TopUserView()
                    .tabItem {
                        Label("Leaderboard", systemImage: "person.3.sequence.fill")
                    }
                
            }
            if(presentingSignUpView){
                UserSignUpView(presentingSignUp: $presentingSignUpView)
            }
        }
        .preferredColorScheme(storageObject.theme ? .light : .dark)
        .onDisappear{
            soundStorage.pauseMusic(sound: SongTheme.theme.rawValue)
            soundStorage.pauseMusic(sound: SongTheme.winning.rawValue)
            soundStorage.pauseMusic(sound: SongTheme.lossing.rawValue)
            UserHistory.lastUser = userDetailStorage.currentUser
        }
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


