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

struct TopUserView: View {
    @EnvironmentObject var userHistoryStorage: UserHistory
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                ScrollView(showsIndicators: true) {
                    VStack(spacing: 25) {
                        ForEach(0..<userHistoryStorage.sortedObjects.count) { index in
                            UserItemView(user: userHistoryStorage.sortedObjects[index]) {
                                // Comment: Display the user's rank (index + 1)
                                return index + 1
                            }
                        }
                    }
                }
            }
            .navigationTitle("Top User")
        }
    }
}

struct TopUserView_Previews: PreviewProvider {
    static var previews: some View {
        TopUserView()
            .environmentObject(UserHistory())
    }
}
