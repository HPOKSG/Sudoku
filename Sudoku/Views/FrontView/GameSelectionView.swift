/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Dinh Gia Huu Phuoc
 ID: s3878270
 Created  date: 25/08/2023
 Last modified: 06/09/2023
 Acknowledgement: COSC2659 Lecture Slides, Apple IOS Development Tutorial
 */


import SwiftUI

struct GameSelectionView: View {
    @EnvironmentObject var storageObject: StorageObject // Access StorageObject
    @EnvironmentObject var userDetailStorage: UserHistory // Access StorageObject
    @Binding var isPresentingNewGame: Bool // Binding to control presentation
    let levels: [String] = ["Easy", "Medium", "Hard"] // Array of difficulty levels
    
    var body: some View {
            List {
                Section {
                    ForEach(0..<levels.count) { index in
                        NavigationLink("\(levels[index].capitalized) Mode") {
                            MainView()
                                .onAppear {
                                    isPresentingNewGame.toggle() // Toggle the presentation state
                                    storageObject.setUpGame(mode: GameMode.getGameMode(levels[index]))
                                    userDetailStorage.increaseGameCount(mode: GameMode.getGameMode(levels[index]))// Set up the game using StorageObject
                                }
                        }
                    }
                } header: {
                    Text("Please Choose The Level") // Display the level as section header
                }
            } // Clip the view into a rounded rectangle
            .frame(width: 360, height: 200) // Set the frame dimensions
        .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        
    
    func getMode(_ mode: String) -> GameMode {
        if (mode == "easy") { return .easy } // Return easy mode
        if (mode == "medium") { return .medium } // Return medium mode
        if (mode == "hard") { return .hard } // Return hard mode
        return .none // Default to none if mode is not recognized
    }
}

struct GameSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectionView(isPresentingNewGame: .constant(true))
            .environmentObject(StorageObject()) // Inject StorageObject into the environment
            .environmentObject(UserHistory()) // Inject StorageObject into the environment
    }
}

