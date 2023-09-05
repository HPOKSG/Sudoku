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

struct GameOverView: View {
    @EnvironmentObject var storageObject: StorageObject
    @EnvironmentObject var soundStorage: SoundDataStorage
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
                            storageObject.gameStatus = .isPlaying
                            StorageObject.currMistake = 0
                            let _ = soundStorage.pauseMusic(sound: SongTheme.lossing.rawValue)
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
            .environmentObject(SoundDataStorage())
    }
}
