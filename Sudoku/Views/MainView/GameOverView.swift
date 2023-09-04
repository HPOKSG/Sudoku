//
//  GameOverView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 04/09/2023.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var storageObject: StorageObject
    var body: some View {
        ZStack{
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            Color("gameOverBackground")
                .frame(width: 300,height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    VStack(spacing: 20){
                        Text("Game Over")
                            .bold()
                            .font(.title2)
                        Text("You have made \(storageObject.maxAttemp) mistakes and lost this game")
                            .font(.footnote)
                            .padding(.horizontal)
                            .bold()
                            .foregroundColor( Color("gray"))
                            .multilineTextAlignment(.center)
                        
                        Button {
                            
                        } label: {
                            Color.black.opacity(0.1)
                                .opacity(0.9)
                                .frame(height: 50)
                                .clipShape(Capsule())
                                .padding(.horizontal)
                                .overlay {
                                    Text("Second Chance")
                                        .bold()
                                        .foregroundColor(Color("gray"))
                                }
                            
                        }
                        Button {
                            
                        } label: {
                            Text("New Game")
                                .bold()
                        }
                    }
            }
        }
        .preferredColorScheme(StorageObject.isLightTheme ? .light : .dark)
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
            .environmentObject(StorageObject())
    }
}
