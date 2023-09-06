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

@main
struct SudokuApp: App {
    @StateObject var storageObject = StorageObject()
    @StateObject var soundStorage = SoundDataStorage()
    @StateObject var userHistoryStorage = UserHistory()
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(storageObject)
                .environmentObject(soundStorage)
                .environmentObject(userHistoryStorage)
            
        }
    }
}
