//
//  VictoryView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 05/09/2023.
//

import SwiftUI

struct VictoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var storageObject : StorageObject
    @State var isPresentingNewGame : Bool = false
    var body: some View {
        ZStack{
            Color("victoryBackground")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20){
                Text("Level Completed!")
                    .bold()
                    .font(.system(size: 42))
                    .foregroundColor(.white)
                VStack{
                    StatisticItemView(imageName: "ranking", title: "Difficulty", description: storageObject.mode.rawValue.capitalized)
                    Divider()
                        .background(.white)
                        .padding(.horizontal,40)
                    StatisticItemView(imageName: "scoreIcon", title: "Score", description: "\(StorageObject.currPoint)")
                    Divider()
                        .background(.white)
                        .padding(.horizontal,40)
                    StatisticItemView(imageName: "timerIcon", title: "Time", description: storageObject.convertToTimer())
                }
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.1))
                        .padding(.horizontal)
                    
                }
                
                Button{
                    presentationMode.wrappedValue.dismiss() 
                }label: {
                    Color.clear
                        .frame(width: 320,height: 70)
                        .clipShape(Capsule())
                        .shadow(radius: 10, y:3)
                        .overlay{
                            Text("Main View")
                                .foregroundColor(Color.white)
                                .bold()
                                .font(.title2)
                        }
                }
                
                
            }
        }
    }
}

struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView()
            .environmentObject(StorageObject())
    }
}

struct StatisticItemView: View {
    var imageName : String
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            HStack{
                Image(imageName)
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 50,height: 50)
                    .scaleEffect(0.23)
                Text(title)
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                Text(description)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(.horizontal)
           
        }
    }
}
