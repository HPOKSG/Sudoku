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
    var body: some Scene {
        WindowGroup {
            FrontView()
                .environmentObject(storageObject)
        }
    }
}
