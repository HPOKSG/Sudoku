//
//  UserItemView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 05/09/2023.
//

import SwiftUI

struct UserItemView: View {
    var user : UserDetail
    var callback : () -> Int
    var body: some View {
            VStack {
                VStack (alignment: .leading,spacing: 15){
                    Text("Top \(callback())")
                        .font(.title3)
                    Text("Name: \(user.name.capitalized)")
                    Text("Game Complete: \(getGameComplete(user:user))")
                    Text("Average Time: \(convertToTimer(user.averageTotalTime))")
                    HStack{
                        Text("Average Score: \(user.averageTotalScore)")
                        Spacer()
                        NavigationLink {
                            StatTabBarView(user: user)
                                .navigationBarTitle("Statistic", displayMode: .inline)
                        } label: {
                            Text("View Detail")
                                .foregroundColor(.black)
                                .padding(.all,5)
                                .padding(.horizontal)
                                .background(Color("gray"))
                                .clipShape(Capsule())
                        }
                        

                    }
                }
                .padding(.all)
                .bold()
                .background{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("itemStat"))
            }
            }
           
            .padding(.horizontal)
        }
    func getGameComplete(user: UserDetail) -> String{
        return "Easy(\(user.totalGameEasy)/5) Medium(\(user.totalGameMedium)/5) Hard(\(user.totalGameHard)/5)"
    }
}

struct UserItemView_Previews: PreviewProvider {
    static var previews: some View {
        UserItemView(user: user1, callback: { () -> Int in
            return 1
        })
    }
}
