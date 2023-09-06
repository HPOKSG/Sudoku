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

struct SplashScreenView: View {
    @EnvironmentObject var storageObject : StorageObject
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if isActive{
            AppView()
        }else{
            ZStack {
                Color(storageObject.theme ? .white : .black)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Image("brain")
                        .renderingMode(.template)
                        .foregroundColor(.red)
                    Text("Let's Play Sudoku")
                        .bold()
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation {
                        self.size = 0.9
                        self.opacity = 1
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.isActive = true
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
            .environmentObject(StorageObject())
            .environmentObject(SoundDataStorage())
            .environmentObject(UserHistory())
    }
}
