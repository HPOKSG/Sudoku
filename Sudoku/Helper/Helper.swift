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
import UIKit
import AVFAudio
func getSize(dimension: inout Double){
    if UIDevice.current.userInterfaceIdiom == .phone {
        dimension = ((UIScreen.main.bounds.size.width-10)/9)*9
    } else if UIDevice.current.userInterfaceIdiom == .pad {
        dimension = UIScreen.main.bounds.size.width * 0.8
    }
}
func vibrateHelper(){
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)

    // Call the prepare method to "warm up" the generator
    impactFeedback.prepare()

    // Trigger the impact feedback
    impactFeedback.impactOccurred()
}

func convertToTimer(_ time: Int) -> String{
    let minute: Int = time/60
    let second: Int =  time%60
    
    let minuteInString = minute >= 10 ? String(minute) : "0\(minute)"
    let secondInstring = second >= 10 ? String(second) : "0\(second)"
    
    return  "\(minuteInString):\(secondInstring)"
}
