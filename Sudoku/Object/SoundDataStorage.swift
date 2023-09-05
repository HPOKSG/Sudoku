//
//  SoundDataStorage.swift
//  Sudoku
//
//  Created by Hữu Phước  on 05/09/2023.
//

import Foundation
import SwiftUI

class SoundDataStorage: ObservableObject{
    @Published var soundOn : Bool{
        didSet{
            Self.isSoundOnStorage = soundOn
        }
    }
    
    @Published var vibrationOn : Bool{
        didSet{
            Self.isVibrationStorage = vibrationOn
        }
    }
    
    @AppStorage ("isSoundOnStorage") static var isSoundOnStorage = true
    
    @AppStorage ("isVibrationStorage") static var isVibrationStorage = true
    
    init() {
        soundOn = Self.isSoundOnStorage
        vibrationOn = Self.isVibrationStorage
    }
}
