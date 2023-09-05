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

struct PauseModalView: View {
    @EnvironmentObject var storageObject :StorageObject
    @Binding var isPlaying: Bool
    var body: some View {
        ZStack{
            Color.black
                .opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            RoundedRectangle(cornerRadius: 20)
                .fill(Color("gameOverBackground"))
                .frame(width: 350,height: 300)
                .overlay{
                    VStack{
                        Text("Pause")
                            .bold()
                            .font(.title)
                            .padding(.all)
                            .padding(.top,20)
                        HStack{
                            VStack{
                                Text("Time")
                                    .foregroundColor(Color("gray"))
                                    .bold()
                                    .padding(.bottom,5)
                                
                                Text(storageObject.convertToTimer())
                                    .bold()
                                    .font(.title3)
                            }
                            Spacer()
                            VStack{
                                Text("Mistake")
                                    .foregroundColor(Color("gray"))
                                    .bold()
                                    .padding(.bottom,5)
                                
                                Text("\(StorageObject.currMistake)/\(storageObject.maxAttemp)")
                                    .bold()
                                    .font(.title3)
                            }
                            Spacer()
                            VStack{
                                Text("Difficulty")
                                    .foregroundColor(Color("gray"))
                                    .bold()
                                    .padding(.bottom,5)
                                Text("\(storageObject.mode.rawValue.capitalized)")
                                    .bold()
                                    .font(.title3)
                            }
                        }
                        .padding(.all)
                        .padding(.horizontal)
                        Spacer()
                        Button {
                            storageObject.gameStatus = .isPlaying
                            
                            let _ = print(StorageObject.gameStatusStorage)
                        } label: {
                            Text("Resume Game")
                                .foregroundColor(.white)
                                .bold()
                                .font(.title3)
                                .frame(width: 300,height: 60)
                                .background(Color("lightBlue"))
                                .clipShape(Capsule())
                                .padding(.bottom)
                        }
                    }
                  
                }
                
        }
    }
}

struct PauseModalView_Previews: PreviewProvider {
    static var previews: some View {
        PauseModalView(isPlaying: .constant(true))
            .environmentObject(StorageObject())
    }
}


