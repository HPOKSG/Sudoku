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

struct SettingAppView: View {
    @EnvironmentObject var soundStorage: SoundDataStorage
    var body: some View {
        List {
            Section {
                VStack{
                    Toggle("Sound", isOn: $soundStorage.soundOn)
                    Toggle("Vibration", isOn: $soundStorage.vibrationOn)
                }
            }
        }
    }
}

struct SettingAppView_Previews: PreviewProvider {
    static var previews: some View {
        SettingAppView()
            .environmentObject(SoundDataStorage())
    }
}
