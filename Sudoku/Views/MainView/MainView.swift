//
//  MainView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 23/08/2023.
//

import SwiftUI

struct MainView: View {
    @State var isPlaying: Bool = false
    @State private var width = ((UIScreen.main.bounds.size.width-10)/9)*9
    @State private var noteStatus  = NoteStatus.off
    @State private var currX = -1
    @State private var currY = -1
    @State private var errorCorrindate = -1
    var body: some View {
        
        ZStack {
            if(isPlaying){
                PauseModalView(isPlaying: $isPlaying)
                    .zIndex(1)
            }
            VStack{
                HeaderView(isPlaying: $isPlaying)
                GridView(currX: $currX, currY: $currY, errorCoordinate: $errorCorrindate)
                ModiferView(noteStatus: $noteStatus, currX: $currX , currY: $currY)
                    .padding([.all,.horizontal])
                NumberView(noteState: $noteStatus, currX: $currX, currY: $currY, errorCoordinate: $errorCorrindate)
                
            }
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
