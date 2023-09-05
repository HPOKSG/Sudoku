//
//  SudokuApp.swift
//  Sudoku
//
//  Created by Hữu Phước  on 22/08/2023.
//

import SwiftUI

@main
struct SudokuApp: App {
    @StateObject var storageObject = StorageObject()
    @StateObject var soundStorage = SoundDataStorage()
    @StateObject var userHistoryStorage = UserHistory()
    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(storageObject)
                .environmentObject(soundStorage)
                .environmentObject(userHistoryStorage)
            
        }
    }
}
