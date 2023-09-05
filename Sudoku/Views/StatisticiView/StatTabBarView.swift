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

struct StatTabBarView: View {
    var user : UserDetail
    @State private var selectedTab = 0
    var body: some View {
            VStack {
                // Custom Tab Bar
                HStack {
                    Spacer()
                    TabBarButton(title: "Easy", isSelected: selectedTab == 0) {
                        withAnimation {
                            selectedTab = 0
                        }
                       
                    }
                    Spacer()
                    TabBarButton(title: "Medium", isSelected: selectedTab == 1) {
                        withAnimation {
                            selectedTab = 1
                        }
                    }
                    Spacer()
                    TabBarButton(title: "Hard", isSelected: selectedTab == 2) {
                        withAnimation {
                            selectedTab = 2
                        }
                    }
                    Spacer()
                }
                .padding()
                
                
                // Content for each tab
                TabView(selection: $selectedTab) {
                    StatsDetailView(userDetail: user, mode: .easy)
                        .tag(0)
                    StatsDetailView(userDetail: user, mode: .medium)
                        .tag(1)
                    StatsDetailView(userDetail: user, mode: .hard)
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }// Ensure content doesn't overlap status bar
            // Set navigation title
        
    }
}

struct StatTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        StatTabBarView(user: user1)
    }
}
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
