//
//  SettingAppView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 05/09/2023.
//

import SwiftUI

struct SettingAppView: View {
    @EnvironmentObject var soundStorage: SoundDataStorage
    var body: some View {
        List {
            Section {
                VStack{
//                    Text("Sound")
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
