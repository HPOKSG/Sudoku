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

// A view representing a tab bar for displaying statistics in different game modes.
struct StatTabBarView: View {
    var user: UserDetail
    @State private var selectedTab = 0
    @EnvironmentObject var soundStorage : SoundDataStorage
    var body: some View {
        VStack {
            // Custom Tab Bar
            HStack {
                Spacer()
                
                // Tab button for the "Easy" game mode.
                TabBarButton(title: soundStorage.language ? "Easy" : "Dễ", isSelected: selectedTab == 0) {
                    withAnimation {
                        selectedTab = 0
                    }
                }
                
                Spacer()
                
                // Tab button for the "Medium" game mode.
                TabBarButton(title: soundStorage.language ? "Medium" : "Trung Bình", isSelected: selectedTab == 1) {
                    withAnimation {
                        selectedTab = 1
                    }
                }
                
                Spacer()
                
                // Tab button for the "Hard" game mode.
                TabBarButton(title: soundStorage.language ? "Hard" : "Khó", isSelected: selectedTab == 2) {
                    withAnimation {
                        selectedTab = 2
                    }
                }
                
                Spacer()
            }
            .padding()
            
            // Content for each tab
            TabView(selection: $selectedTab) {
                // Display statistics for the "Easy" game mode.
                StatsDetailView(userDetail: user, mode: .easy)
                    .tag(0)
                
                // Display statistics for the "Medium" game mode.
                StatsDetailView(userDetail: user, mode: .medium)
                    .tag(1)
                
                // Display statistics for the "Hard" game mode.
                StatsDetailView(userDetail: user, mode: .hard)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct StatTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the StatTabBarView with sample user data.
        StatTabBarView(user: user1)
            .environmentObject(SoundDataStorage())
    }
}

// A custom button view for tab bar buttons.
struct TabBarButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(isSelected ? .headline : .subheadline)
                .foregroundColor(isSelected ? .blue : .gray)
        }
    }
}

