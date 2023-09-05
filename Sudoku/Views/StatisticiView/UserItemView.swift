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

struct UserItemView: View {
    var user : UserDetail
    var callback : () -> Int
    var body: some View {
        VStack () {
                VStack (alignment: .leading,spacing: 25){
                    Text("Top \(callback())")
                        .font(.title3)
                    Text("Name: \(user.name.capitalized)")
                    Text("Average Time: \(convertToTimer(user.averageTotalTime))")
                    Text("Average Score: \(user.averageTotalScore)")
                    HStack{
                        HStack(spacing: 0){
                            Text("Earned Batch: ")
                            if (user.badge.count > 0){
                                let badges = user.badge.components(separatedBy: ",")
                                ForEach(0..<badges.count) { index in
                                    Image(badges[index])
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 45,height: 45)
                                }
                            }else{
                                Text("None")
                            }
                        }
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
