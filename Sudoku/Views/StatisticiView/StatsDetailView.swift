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

// A view to display detailed statistics for a user in a specific game mode.
struct StatsDetailView: View {
    var userDetail: UserDetail
    var mode: GameMode
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Display the game statistics section.
                GameStatSection(user: userDetail, mode: mode)
                
                // Display the time statistics section.
                TimeStatSection(user: userDetail, mode: mode)
                
                // Display the score statistics section.
                ScoreStatSection(user: userDetail, mode: mode)
            }
        }
    }
}

struct StatsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the StatsDetailView with sample data for user1 in hard mode.
        StatsDetailView(userDetail: user1, mode: .hard)
            .environmentObject(SoundDataStorage())
    }
}

// A reusable view to display individual statistics with an image, title, and value.
struct StatItemView: View {
    var image: String
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Image(image)
                    .renderingMode(.template)
                    .frame(width: 50, height: 50)
                    .scaleEffect(0.23)
                    .foregroundColor(Color("lightBlue"))
                Text(title)
                    .bold()
            }
            Spacer()
            Text(value)
                .bold()
                .font(.title3)
        }
        .padding(.all)
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("itemStat")) // Apply a background color to the stat item.
        }
    }
}


struct GameStatSection: View {
    @EnvironmentObject var soundStorage : SoundDataStorage
    var user: UserDetail
    var mode: GameMode
    @State var data: [Int] = [1, 2, 3] // Placeholder data
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(soundStorage.language ? "Games" : "Trò Chơi")
                .bold()
                .font(.title2)
            
            // Display the number of games started.
            StatItemView(image: "sudoku", title: soundStorage.language ? "Game Started" : "Game Đã Chơi", value: data[0] == 0 ? "-" : "\(data[0])")
            
            // Display the number of games won.
            StatItemView(image: "gameWon", title: soundStorage.language ? "Game Won" : "Game Đã Thắng", value: data[1] == 0 ? "-" : "\(data[1])")
            
            // Display the win rate (percentage of games won).
            StatItemView(image: "winrate", title: soundStorage.language ? "Win Rate" : "Tỉ Lệ Thắng", value: data[2] == 0 ? "-" : "\(data[2])%")
        }.onAppear {
            // Load data based on the selected game mode.
            getData()
        }
    }
    
    // Function to retrieve data based on the selected game mode.
    func getData() {
        if mode == .easy {
            // Calculate win rate percentage for easy mode.
            let percentage = user.totalGameEasy > 0 ? (user.totalGameEasyWon * 100 / user.totalGameEasy) : 0
            data = [user.totalGameEasy, user.totalGameEasyWon, percentage]
        } else if mode == .medium {
            // Calculate win rate percentage for medium mode.
            let percentage = user.totalGameMedium > 0 ? (user.totalGameMediumWon * 100 / user.totalGameMedium) : 0
            data = [user.totalGameMedium, user.totalGameMediumWon, percentage]
        } else if mode == .hard {
            // Calculate win rate percentage for hard mode.
            let percentage = user.totalGameHard > 0 ? (user.totalGameHardWon * 100 / user.totalGameHard) : 0
            data = [user.totalGameHard, user.totalGameHardWon, percentage]
        }
    }
}

struct TimeStatSection: View {
    @EnvironmentObject var soundStorage : SoundDataStorage
    var user: UserDetail
    var mode: GameMode
    @State var data: [Int] = [1, 2] // Placeholder data
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(soundStorage.language ? "Time" : "Thời Gian")
                .bold()
                .font(.title2)
            
            // Display the best time.
            StatItemView(image: "bestTime", title: soundStorage.language ? "Best Time" : "Thời Gian Nhanh Nhất", value: data[0] == 0 ? "-" : convertToTimer(data[0]))
            
            // Display the average time.
            StatItemView(image: "averageTime", title: soundStorage.language ? "Average Time" : "Thời Gian Trung Bình", value: data[1] == 0 ? "-" : convertToTimer(data[1]))
        }.onAppear {
            // Load data based on the selected game mode.
            getData()
        }
    }
    
    // Function to retrieve data based on the selected game mode.
    func getData() {
        if mode == .easy {
            data = [user.bestTimeEasy, user.averageTimeEasy]
        } else if mode == .medium {
            data = [user.bestTimeMedium, user.averageTimeMedium]
        } else if mode == .hard {
            data = [user.bestTimeHard, user.averageTimeHard]
        }
    }
}

struct ScoreStatSection: View {
    @EnvironmentObject var soundStorage : SoundDataStorage
    var user: UserDetail
    var mode: GameMode
    @State var data: [Int] = [1, 2] // Placeholder data
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(soundStorage.language ? "Score" : "Điểm")
                .bold()
                .font(.title2)
            
            // Display the best score.
            StatItemView(image: "bestScore", title: soundStorage.language ? "Best Score" : "Điểm Cao Nhất", value: data[0] == 0 ? "-" : "\(data[0])")
            
            // Display the average score.
            StatItemView(image: "averageScore", title: soundStorage.language ? "Average Score" : "Điểm Trung Bình", value: data[1] == 0 ? "-" : "\(data[1])")
        }.onAppear {
            // Load data based on the selected game mode.
            getData()
        }
    }
    
    // Function to retrieve data based on the selected game mode.
    func getData() {
        if mode == .easy {
            data = [user.bestScoreEasy, user.averageScoreEasy]
        } else if mode == .medium {
            data = [user.bestScoreMedium, user.averageScoreMedium]
        } else if mode == .hard {
            data = [user.bestScoreHard, user.averageScoreHard]
        }
    }
}

