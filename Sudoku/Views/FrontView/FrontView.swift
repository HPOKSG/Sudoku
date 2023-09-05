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

struct FrontView: View {
    @EnvironmentObject var storageObject : StorageObject
    @EnvironmentObject var userDetailStorage : UserHistory
    @State private var isPresentingNewGame: Bool = false
    @State private var isPresentingThemeController: Bool = false
    @Binding var isPresentingSignUpView : Bool
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
                            MainView().onAppear{
                                isPresentingThemeController = false
                                userDetailStorage.increaseGameCountWhenContinue(mode: storageObject.mode)
                            }
                        } label: {
                            ContinueGameButtonView()
                        }
                        
                    }
                    Button {
                        //in crease game cound when start new game
                        userDetailStorage.increaseGameCount(mode: storageObject.mode)
                        isPresentingThemeController = false
                        //turn off the map selection view
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
                    .disabled(isPresentingSignUpView)
                
                ThemeSettingView()
                    .position(isPresentingThemeController ? CGPoint(x:  UIScreen.main.bounds.width - 195, y: 100) : CGPoint(x:  UIScreen.main.bounds.width, y: UIScreen.main.bounds.height))
            }
        }
    }
}

struct FrontView_Previews: PreviewProvider {
    static var previews: some View {
        FrontView(isPresentingSignUpView: .constant(true))
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
