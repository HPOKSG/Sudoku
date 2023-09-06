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

struct MainView: View {
    @EnvironmentObject var storageObject: StorageObject // Access StorageObject from the environment
    @EnvironmentObject var soundStorage: SoundDataStorage // Access SoundDataStorage from the environment
    @EnvironmentObject var userDetailStorage: UserHistory // Access UserHistory from the environment
    @State var isPlaying: Bool = true // State to control play/pause of game sound
    @State var dimension: Double = 0 // Grid dimension
    @State private var width = ((UIScreen.main.bounds.size.width-10)/9)*9 // Grid width
    @State private var noteStatus = NoteStatus.off // Status of number notes
    @State private var currX = -1 // Current X coordinate
    @State private var currY = -1 // Current Y coordinate
    @State private var errorPopUP: Bool = false // Error popup state
    @State private var position = 0 // Error popup position

    var body: some View {
        
        ZStack {
            Color("mainviewBackground") // Background color
                .edgesIgnoringSafeArea(.all) // Ignore safe area edges
            
            VStack{
                HeaderView() // Display the header view
                
                GridView(dimension: $dimension, currX: $currX, currY: $currY) // Display the game grid
                
                ModiferView(noteStatus: $noteStatus, currX: $currX , currY: $currY) // Display modifier buttons
                    .padding([.all,.horizontal]) // Add padding
                
                NumberView(noteState: $noteStatus, currX: $currX, currY: $currY, errorPopUP: $errorPopUP) // Display number buttons
                
            }
            
            ErrorView(errorMessage: "Can't fill in a pre-filled cell") // Error view for pre-filled cell error
                .position(x: UIScreen.main.bounds.width/2, y: errorPopUP ? 100 : -30) // Position error view
                .edgesIgnoringSafeArea(.top) // Ignore safe area edges
            
            if (GameStatus.getGameStatus(StorageObject.gameStatusStorage) == .lost) {
                GameOverView() // Display the game over view
            }
            
            if (storageObject.gameStatus == .pause) {
                PauseModalView(isPlaying: $isPlaying) // Display the pause modal view
                    .zIndex(2) // Set z-index for stacking order
            }
            
            if (storageObject.gameStatus == .won) {
                VictoryView() // Display the victory view
            }
        }
        .onAppear {
            getSize(dimension: &dimension) // Get the grid size on appearance
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(StorageObject())
            .environmentObject(SoundDataStorage())
            .environmentObject(UserHistory())
    }
}

enum NoteStatus{
    case off
    case on
}
