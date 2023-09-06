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
    // Environment property to manage presentation mode
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var storageObject: StorageObject
    @EnvironmentObject var soundStorage: SoundDataStorage
    
    var body: some View {
        ZStack {
            // Semi-transparent black background covering the entire screen
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            
            // Game over message and options
            Color("gameOverBackground")
                .frame(width: 300, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    VStack(spacing: 20) {
                        // Game over title
                        Text("Game Over")
                            .bold()
                            .font(.title2)
                        
                        // Message about mistakes and losing the game
                        Text("You have made \(storageObject.maxAttemp) mistakes and lost this game")
                            .font(.footnote)
                            .padding(.horizontal)
                            .bold()
                            .foregroundColor(Color("gray"))
                            .multilineTextAlignment(.center)
                        
                        // Second chance button
                        Button {
                            storageObject.gameStatus = .isPlaying
                            StorageObject.currMistake = 0
                            soundStorage.pauseMusic(sound: SongTheme.lossing.rawValue)
                        } label: {
                            // Styled button for a second chance
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
                            soundStorage.playSound(sound: SongTheme.theme.rawValue)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            // Styled button for a second chance
                            Color.black.opacity(0.1)
                                .opacity(0.9)
                                .frame(height: 50)
                                .clipShape(Capsule())
                                .padding(.horizontal)
                                .overlay {
                                    Text("Main")
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
