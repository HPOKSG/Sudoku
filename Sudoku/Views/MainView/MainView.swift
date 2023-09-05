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
    @EnvironmentObject var storageObject : StorageObject
    @EnvironmentObject var soundStorage : SoundDataStorage
    @EnvironmentObject var userDetailStorage : UserHistory
    @State var isPlaying: Bool = true
    @State var dimension: Double = 0
    @State private var width = ((UIScreen.main.bounds.size.width-10)/9)*9
    @State private var noteStatus  = NoteStatus.off
    @State private var currX = -1
    @State private var currY = -1
    @State private var errorPopUP: Bool = false
    @State private var position = 0
    var body: some View {
        
        ZStack {
           Color("mainviewBackground")
                .edgesIgnoringSafeArea(.all)
            VStack{
                HeaderView()
                GridView(dimension: $dimension, currX: $currX, currY: $currY)
                ModiferView(noteStatus: $noteStatus, currX: $currX , currY: $currY)
                    .padding([.all,.horizontal])
                NumberView(noteState: $noteStatus, currX: $currX, currY: $currY, errorPopUP: $errorPopUP)
                
            }
            ErrorView(errorMessage: "Can't fill in a pre-filled cell")
                .position(x: UIScreen.main.bounds.width/2, y: errorPopUP ? 100 : -30)
                .edgesIgnoringSafeArea(.top)
            
            if (GameStatus.getGameStatus(StorageObject.gameStatusStorage) == .lost){
                let _ = soundStorage.pauseMusic(sound: SongTheme.theme.rawValue)
                let _ = soundStorage.playSound(sound: SongTheme.lossing.rawValue)
                GameOverView()
            }
            if(storageObject.gameStatus == .pause){
                PauseModalView(isPlaying: $isPlaying)
                    .zIndex(2)
            }
            if(storageObject.gameStatus == .won){
                let _ = soundStorage.pauseMusic(sound: SongTheme.theme.rawValue)
                let _ = soundStorage.playSound(sound: SongTheme.winning.rawValue)
                let _ = userDetailStorage.updateUserDetail(mode: storageObject.mode, point: StorageObject.currPoint, time: storageObject.secondsElapsed)
                VictoryView()
            }
            
        }
        .onAppear{
            getSize(dimension: &dimension)
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
