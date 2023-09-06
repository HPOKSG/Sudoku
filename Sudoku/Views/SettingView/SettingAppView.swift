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

// A view for configuring application settings related to sound and vibration.
struct SettingAppView: View {
    @EnvironmentObject var soundStorage: SoundDataStorage
    
    var body: some View {
        List {
            Section {
                VStack {
                    // Toggle switch for enabling/disabling sound.
                    Toggle(soundStorage.language ? "Sound" : "Nhạc", isOn: $soundStorage.soundOn)
                    
                    // Toggle switch for enabling/disabling vibration.
                    Toggle(soundStorage.language ? "Vibration" : "Rung", isOn: $soundStorage.vibrationOn)
                    
                    Toggle(soundStorage.language ?  "English/Vietnamese" : "Tiếng Anh / Tiếng Việt", isOn: $soundStorage.language)
                    
                    
                }
            }
        }
    }
}

struct SettingAppView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the SettingAppView with an environment object for sound data storage.
        SettingAppView()
            .environmentObject(SoundDataStorage())
    }
}

