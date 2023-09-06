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

// A view representing an item for displaying user statistics and details.
struct UserItemView: View {
    @EnvironmentObject var soundStorage : SoundDataStorage
    var user: UserDetail
    var callback: () -> Int
    
    var body: some View {
        VStack() {
            VStack(alignment: .leading, spacing: 25) {
                // Display the user's ranking.
                Text(soundStorage.language ? "Top \(callback())" :"Vị trí số \(callback())")
                    .font(.title3)
                
                // Display the user's name.
                Text(soundStorage.language ? "Name: \(user.name.capitalized)" : "Tên: \(user.name.capitalized)" )
                
                // Display the user's average time.
                Text(soundStorage.language ? "Average Time: \(convertToTimer(user.averageTotalTime))" : "Thời Gian Trunh Bình: \(convertToTimer(user.averageTotalTime))")
                
                // Display the user's average score.
                Text(soundStorage.language ? "Average Score: \(user.averageTotalScore)": "Điểm Trung Bình: \(user.averageTotalScore)")
                
                HStack {
                    HStack(spacing: 0) {
                        Text(soundStorage.language ? "Earned Batch: " : "Huy Hiệu: ")
                        Spacer()
                        // Display the user's earned badges.
                        if user.badge.count > 0 {
                            let badges = user.badge.components(separatedBy: ",")
                            ForEach(0..<badges.count) { index in
                                Image(badges[index])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                            }
                        } else {
                            // Display "None" if the user has no badges.
                            Text("None")
                        }
                    }
                    
                    Spacer()
                    
                    // Add a navigation link to view detailed statistics.
                    NavigationLink {
                        StatTabBarView(user: user)
                            .navigationBarTitle("Statistic", displayMode: .inline)
                    } label: {
                        Text("View Detail")
                            .foregroundColor(.black)
                            .padding(.all, 5)
                            .background(Color("gray"))
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.all)
            .bold()
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("itemStat")) // Apply a background color to the item.
            }
        }
        .padding(.horizontal)
    }
    
    // Function to format and return the string representing game completion.
    func getGameComplete(user: UserDetail) -> String {
        return "Easy(\(user.totalGameEasy)/5) Medium(\(user.totalGameMedium)/5) Hard(\(user.totalGameHard)/5)"
    }
}

struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the UserItemView with sample user data and a callback function.
        UserItemView(user: user1, callback: { () -> Int in
            return 1
        })
        .environmentObject(SoundDataStorage())
    }
}

