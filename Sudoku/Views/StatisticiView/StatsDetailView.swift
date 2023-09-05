//
//  StatsDetailView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 05/09/2023.
//

import SwiftUI

struct StatsDetailView: View {
    var userDetail : UserDetail
    var mode : GameMode
    var body: some View {
        ScrollView {
            VStack(spacing: 30){
                GameStatSection(user: userDetail, mode: mode)
                TimeStatSection(user: userDetail, mode: mode)
                ScoreStatSection(user: userDetail, mode: mode)
            }
        }
        
    }
}

struct StatsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StatsDetailView(userDetail: user1, mode: .hard)
    }
}

struct StatItemView: View {
    var image : String
    var title : String
    var value : String
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Image(image)
                    .renderingMode(.template)
                    .frame(width: 50,height: 50)
                    .scaleEffect(0.23)
                Text(title)
                    .bold()
                
            }
            Spacer()
            Text(value)
                .bold()
                .font(.title3)
        }
        .padding(.all)
        .background{
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("itemStat"))
        }
    }
}

struct GameStatSection: View {
    var user: UserDetail
    var mode : GameMode
    @State var data: [Int] = [1,2,3]
    var body: some View {
        VStack(alignment: .leading){
            Text("Games")
                .bold()
                .font(.title2)
            StatItemView(image: "sudoku", title: "Game Started", value: data[0] == 0 ? "-" : "\(data[0])")
            StatItemView(image: "gameWon", title: "Game Won", value: data[1] == 0 ? "-" : "\(data[1])")
            StatItemView(image: "winrate", title: "Win Rate", value: data[2] == 0 ? "-" : "\(data[2])")
            
        }.onAppear{
            getData()
        }
    }
    
    func getData(){
        if mode == .easy{
            let percentage = user.totalGameEasyWon * 100 / user.totalGameEasy
            data = [user.totalGameEasy,user.totalGameEasyWon, percentage]
        }else if mode == .medium{
            let percentage = user.totalGameMediumWon * 100 / user.totalGameMedium
            data = [user.totalGameMedium,user.totalGameMediumWon, percentage]
        }else if mode == .hard{
            let percentage = user.totalGameHardWon * 100 / user.totalGameHard
            data = [user.totalGameHard,user.totalGameHardWon, percentage]
        }
    }
}

struct TimeStatSection: View {
    var user: UserDetail
    var mode : GameMode
    @State var data: [Int] = [1,2]
    var body: some View {
        VStack(alignment: .leading){
            Text("Time")
                .bold()
                .font(.title2)
            StatItemView(image: "bestTime", title: "Best Time", value: data[0] == 0 ? "-" : convertToTimer(data[0]))
            StatItemView(image: "averageTime", title: "Average Time", value:  data[1] == 0 ? "-" : convertToTimer(data[1]))
        }
        .onAppear{
            getData()
        }
    }
    func getData(){
        if mode == .easy{
            data = [user.bestTimeEasy,user.averageTimeEasy]
        }else if mode == .medium{
            data = [user.bestTimeMedium,user.averageTimeMedium]
        }else if mode == .hard{
            data = [user.bestTimeHard,user.averageTimeHard]
        }
    }
}
struct ScoreStatSection: View {
    var user: UserDetail
    var mode : GameMode
    @State var data: [Int] = [1,2]
    var body: some View {
        VStack(alignment: .leading){
            Text("Score")
                .bold()
                .font(.title2)
            StatItemView(image: "bestScore", title: "Best Score", value: data[0] == 0 ? "-" : "\(data[0])")
            StatItemView(image: "averageScore", title: "Average Score", value: data[1] == 0 ? "-" : "\(data[1])")
        }.onAppear{
            getData()
        }
    }
    func getData(){
        if mode == .easy{
            data = [user.bestScoreEasy,user.averageScoreEasy]
        }else if mode == .medium{
            data = [user.bestScoreMedium,user.averageScoreMedium]
        }else if mode == .hard{
            data = [user.bestScoreHard,user.averageScoreHard]
        }
    }
}

