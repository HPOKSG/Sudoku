//
//  FrontView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 31/08/2023.
//

import SwiftUI

struct FrontView: View {
    @EnvironmentObject var storageObject : StorageObject
    @State private var isPresentingNewGame: Bool = false
    @State private var isPresentingThemeController: Bool = false
   
    var body: some View {
        NavigationStack {
            ZStack{
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing:30) {
                    Spacer()
                    
                    GameNameView()
                        .font(.system(size: 50))
                        .bold()
                        .padding(.bottom,70)
                    
                    //continue to play button
                    if(storageObject.gameStatus == .isPlaying){
                        NavigationLink {
                            MainView()
                        } label: {
                            ContinueGameButtonView()
                        }
                        
                    }
                    Button {
                        withAnimation {
                            isPresentingNewGame.toggle()
                        }
                    } label: {
                        NewGameButtonView()
                    }
                    Spacer(minLength: 150)
                }
                
                ZStack {
                    // Your main content goes here
                    // Background view with a tap gesture recognizer
                    if isPresentingNewGame{
                        Color.black.opacity(0.3) // Semi-transparent background
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation {
                                    isPresentingNewGame.toggle() // Toggle the state
                                }
                            }
                    }
                    // Pop-up view
                    GameSelectionView(isPresentingNewGame: $isPresentingNewGame)
                        .offset(y: isPresentingNewGame ? 200 : UIScreen.main.bounds.height)
                }
            
                SettingView(isPresentingThemeController: $isPresentingThemeController)
                
                ThemeSettingView()
                    .offset(y: isPresentingThemeController ? -290 : -(UIScreen.main.bounds.height))
            }
        }
    }
}

struct FrontView_Previews: PreviewProvider {
    static var previews: some View {
        FrontView()
            .environmentObject(StorageObject())
            .environmentObject(SoundDataStorage())
            .environmentObject(UserHistory())
        
    }
}

struct GameNameView: View {
    var body: some View {
        HStack(spacing: 0){
            Text("Sudoku")
                .foregroundColor(Color("textFontView"))
            Text(".")
                .foregroundColor(Color("lightBlue"))
                .font(.system(size: 65))
                .padding(.bottom,10)
            Text("com")
                .foregroundColor(Color("textFontView"))
        }
    }
}

struct ContinueGameButtonView: View {
    @EnvironmentObject var storageObject: StorageObject
    var body: some View {
        ZStack {
            Color("lightBlue")
                .frame(width: 320,height: 70)
                .clipShape(Capsule())
                .overlay{
                    Text("Continue Game")
                        .foregroundColor(.white)
                        .bold()
                        .font(.title2)
                        .padding(.bottom,25)
                    HStack{
                        Image(systemName: "clock")
                        Text("\(storageObject.convertToTimer()) - \(storageObject.mode.rawValue.capitalized)")
                    }
                    .padding(.top,30)
                    .bold()
                    .foregroundColor(.white)
                }
        }
    }
}

struct NewGameButtonView: View {
    @EnvironmentObject var storageObject: StorageObject
    var body: some View {
        ZStack {
            Color("newGameColor")
                .frame(width: 320,height: 70)
                .clipShape(Capsule())
                .shadow(radius: 10, y:3)
                .overlay{
                    Text("New Game")
                        .foregroundColor(Color("lightBlue"))
                        .bold()
                        .font(.title2)
                }
            
        }
    }
}
struct SettingView: View {
    @Binding var isPresentingThemeController: Bool
    var body: some View {
            VStack{
                HStack(spacing:20){
                    Spacer()
                    Button {
                        isPresentingThemeController.toggle()
                    } label: {
                        Image(systemName: "paintpalette")
                            .bold()
                            .font(.title)
                            .foregroundColor(Color("lightBlue"))
                    }
                    
                   
                    Button {
                        
                    } label: {
                        Image(systemName: "trophy")
                            .bold()
                            .font(.title)
                            .foregroundColor(Color("lightBlue"))
                    }
                    
                    
                    
                    NavigationLink {
                       SettingAppView()
                            .navigationTitle("Setting")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                   
                    label: {
                        Image(systemName: "gearshape")
                            .bold()
                            .font(.title)
                            .foregroundColor(Color("lightBlue"))
                    }
                    
                    
                    
                }
                .padding(.horizontal)
                Spacer()
            }
    }
}
