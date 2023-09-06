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

// A view representing the front page of the application.
struct FrontView: View {
    @EnvironmentObject var storageObject: StorageObject
    @EnvironmentObject var userDetailStorage: UserHistory
    @State private var isPresentingNewGame: Bool = false
    @State private var isPresentingThemeController: Bool = false
    @State private var isPresentingHowToPlay: Bool = false
    @Binding var isPresentingSignUpView: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 30) {
                    Spacer()
                    
                    // View displaying the game name or logo.
                    GameNameView()
                        .font(.system(size: 50))
                        .bold()
                        .padding(.bottom, 70)
                    
                    // Continue to play button if a game is in progress.
                    if storageObject.gameStatus == .isPlaying {
                        NavigationLink {
                            MainView()
                                .toolbar(.hidden, for: .tabBar)
                                .onAppear {
                                isPresentingThemeController = false
                                userDetailStorage.increaseGameCountWhenContinue(mode: storageObject.mode)
                            }
                           
                        } label: {
                            ContinueGameButtonView()
                        }
                    }
                    
                    // Button to start a new game.
                    Button {
                        // Increase game count when starting a new game.
                        isPresentingThemeController = false
                        
                        // Toggle the map selection view.
                        withAnimation {
                            isPresentingNewGame.toggle()
                        }
                    } label: {
                        NewGameButtonView()
                    }
                    
                    Button {
                        // Increase game count when starting a new game.
                        isPresentingHowToPlay = false
                        
                        // Toggle the map selection view.
                        withAnimation {
                            isPresentingHowToPlay.toggle()
                        }
                    } label: {
                        HowToPlayButton()
                    }
                    .sheet(isPresented: $isPresentingHowToPlay) {
                        HowToPlayView()
                    }
                    
                    Spacer(minLength: 150)
                }
                
                // Background and pop-up view for game selection.
                ZStack {
                    // Semi-transparent background with tap gesture to dismiss the pop-up.
                    if isPresentingNewGame {
                        Color.black.opacity(0.3)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                withAnimation {
                                    isPresentingNewGame.toggle()
                                }
                            }
                    }
                    
                    // Pop-up view for game selection.
                    GameSelectionView(isPresentingNewGame: $isPresentingNewGame)
                        .offset(y: isPresentingNewGame ? 200 : UIScreen.main.bounds.height)
                }
                
                // View for configuring application settings.
                SettingView(isPresentingThemeController: $isPresentingThemeController)
                    .disabled(isPresentingSignUpView)
                
                // View for theme settings.
                ThemeSettingView()
                    .position(isPresentingThemeController ? CGPoint(x: UIScreen.main.bounds.width - 140, y: 100) : CGPoint(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height))
            }
        }
    }
}


struct FrontView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview for the FrontView
        FrontView(isPresentingSignUpView: .constant(true))
            .environmentObject(StorageObject()) // Inject StorageObject
            .environmentObject(SoundDataStorage()) // Inject SoundDataStorage
            .environmentObject(UserHistory()) // Inject UserHistory
    }
}

struct GameNameView: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("Sudoku") // Display "Sudoku"
                .foregroundColor(Color("textFontView")) // Set text color
            
            Text(".") // Display a dot separator
                .foregroundColor(Color("lightBlue")) // Set dot color
                .font(.system(size: 65)) // Set font size
                .padding(.bottom, 10) // Add bottom padding
            
            Text("com") // Display "com"
                .foregroundColor(Color("textFontView")) // Set text color
        }
    }
}

struct ContinueGameButtonView: View {
    @EnvironmentObject var storageObject: StorageObject // Access StorageObject
    var body: some View {
        ZStack {
            Color("lightBlue") // Set background color
                .frame(width: 320, height: 70) // Set frame dimensions
                .clipShape(Capsule()) // Clip the view into a capsule shape
            
                .overlay {
                    Text("Continue Game") // Display "Continue Game"
                        .foregroundColor(.white) // Set text color
                        .bold() // Apply bold font style
                        .font(.title2) // Set font size
                        .padding(.bottom, 25) // Add bottom padding
                    
                    HStack {
                        Image(systemName: "clock") // Display a clock icon
                        Text("\(storageObject.convertToTimer()) - \(storageObject.mode.rawValue.capitalized)") // Display timer and mode
                    }
                    .padding(.top, 30) // Add top padding
                    .bold() // Apply bold font style
                    .foregroundColor(.white) // Set text color
                }
        }
    }
}


// A view representing a button for starting a new game.
struct NewGameButtonView: View {
    @EnvironmentObject var storageObject: StorageObject
    
    var body: some View {
        ZStack {
            Color("newGameColor")
                .frame(width: 320, height: 70)
                .clipShape(Capsule())
                .shadow(radius: 10, y: 3)
                .overlay {
                    // Text label for the "New Game" button.
                    Text("New Game")
                        .foregroundColor(Color("lightBlue"))
                        .bold()
                        .font(.title2)
                }
        }
    }
}

// A view representing a button for starting a new game.
struct HowToPlayButton: View {
    @EnvironmentObject var storageObject: StorageObject
    
    var body: some View {
        ZStack {
            Color("lightBlue")
                .frame(width: 320, height: 70)
                .clipShape(Capsule())
                .shadow(radius: 10, y: 3)
                .overlay {
                    // Text label for the "New Game" button.
                    Text("How To Play")
                        .foregroundColor(.white)
                        .bold()
                        .font(.title2)
                }
        }
    }
}


// A view for configuring application settings and navigation to different sections.
struct SettingView: View {
    @Binding var isPresentingThemeController: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Spacer()
                
                // Button to toggle the theme controller.
                Button {
                    isPresentingThemeController.toggle()
                } label: {
                    Image(systemName: "paintpalette")
                        .bold()
                        .font(.title)
                        .foregroundColor(Color("lightBlue"))
                }
                
                
                // Navigation link to the app settings.
                NavigationLink {
                    SettingAppView()
                        .navigationTitle("Setting")
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
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
