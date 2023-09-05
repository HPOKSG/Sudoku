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

struct GameSelectionView: View {
    @EnvironmentObject var storageObject: StorageObject
    @Binding var isPresentingNewGame: Bool
    let levels: [String] = ["easy","medium","hard"]
    var body: some View {
            List(levels, id: \.self) { level in
                Section {
                    if let maps = gameMap[level]{
                        ForEach(0..<maps.count) { index in
                            NavigationLink("MAP \(index+1)") {
                                MainView()
                                    .onAppear{
                                        isPresentingNewGame.toggle()
                                        storageObject.setUpGame(mode: getMode(level), map: maps[index])
                                    }
                            }
                        }
                    }
                } header: {
                    Text(level)
                }
                
                
            }
            .frame(width: 360, height: 280)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
        
        
    }
    func getMode(_ mode: String)->GameMode{
        if (mode == "easy"){return .easy}
        if (mode == "medium"){return .medium}
        if (mode == "hard"){return .hard}
        return .none
    }
}

struct GameSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectionView(isPresentingNewGame: .constant(true))
            .environmentObject(StorageObject())
    }
}
