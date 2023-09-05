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


import Foundation
import SwiftUI
import AVFoundation
class SoundDataStorage: ObservableObject{
    @Published var soundOn : Bool{
        didSet{
            Self.isSoundOnStorage = soundOn
            playSound(sound: SongTheme.theme.rawValue)
        }
    }
    
    @Published var vibrationOn : Bool{
        didSet{
            Self.isVibrationStorage = vibrationOn
        }
    }
    
    @AppStorage ("isSoundOnStorage") static var isSoundOnStorage = true
    
    @AppStorage ("isVibrationStorage") static var isVibrationStorage = true
    
    
    var audioPlayer: AVAudioPlayer?
    
    
    init() {
        soundOn = Self.isSoundOnStorage
        vibrationOn = Self.isVibrationStorage
        playSound(sound: SongTheme.theme.rawValue)
    }
    
    
    func playSound(sound: String){
        if let path = Bundle.main.path(forResource: sound, ofType: "mp3"){
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.numberOfLoops = .max
                if soundOn{
                    audioPlayer?.play()
                }else{
                    audioPlayer?.stop()
                }
               
            }catch{
                print("ERROR: Could not find and play the sound file")
            }
        }
    }
    func pauseMusic(sound: String){
        if let path = Bundle.main.path(forResource: sound, ofType: "mp3"){
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.stop()
            }catch{
                print("ERROR: Could not find and play the sound file")
            }
        }
    }
}

enum SongTheme : String{
    case theme = "theme"
    case winning = "winning"
    case lossing = "loosing"
}
