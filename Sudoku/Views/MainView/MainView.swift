//
//  MainView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 23/08/2023.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var storageObject : StorageObject
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
                .position(x: dimension/2, y: errorPopUP ? 100 : -30)
                .edgesIgnoringSafeArea(.top)
            
            if (GameStatus.getGameStatus(StorageObject.gameStatusStorage) == .lost){
                GameOverView()
            }
            if(storageObject.gameStatus == .pause){
                PauseModalView(isPlaying: $isPlaying)
                    .zIndex(2)
            }
            if(storageObject.gameStatus == .won){
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
    }
}

enum NoteStatus{
    case off
    case on
}
