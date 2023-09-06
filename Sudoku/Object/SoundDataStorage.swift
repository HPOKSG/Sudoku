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
    
    //Delcare soundOn to check for if the user want sound on or off
    @Published var soundOn : Bool{
        didSet{
            Self.isSoundOnStorage = soundOn
            playSound(sound: SongTheme.theme.rawValue)
        }
    }
    
    //Delcare soundOn to check for if the user want sound on or off
    @Published var vibrationOn : Bool{
        didSet{
            Self.isVibrationStorage = vibrationOn
        }
    }
    
    //Declare Appstorage to store the data of soundON variable
    @AppStorage ("isSoundOnStorage") static var isSoundOnStorage = true
    
    //Declare Appstorage to store the data of vibrationON variable
    @AppStorage ("isVibrationStorage") static var isVibrationStorage = true
    
    //Declare AvAuioPlayer variable for playing music
    var audioPlayer: AVAudioPlayer?
    
    // init the Object
    init() {
        soundOn = Self.isSoundOnStorage
        vibrationOn = Self.isVibrationStorage
        playSound(sound: SongTheme.theme.rawValue)
    }
    
    //this function will enable the system to player the spcified music file
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
    
    //this function will enable the system to pause the specified music file
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
    func vibrate(){
        if vibrationOn{
            vibrateHelper()
        }
    }
    func playErrorMove(){
        if(soundOn){
            AudioServicesPlaySystemSound(1010)
        }
       
    }
    func playValidMove(){
        if(soundOn){
            AudioServicesPlaySystemSound(1008);
        }
    }
    
}

//declare SongTheme for easy usage
enum SongTheme : String{
    case theme = "theme"
    case winning = "winning"
    case lossing = "loosing"
}
