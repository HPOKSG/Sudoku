//
//  Helper.swift
//  Sudoku
//
//  Created by Hữu Phước  on 31/08/2023.
//

import Foundation
import SwiftUI
import UIKit

func getSize(dimension: inout Double){
    if UIDevice.current.userInterfaceIdiom == .phone {
        dimension = ((UIScreen.main.bounds.size.width-10)/9)*9
    } else if UIDevice.current.userInterfaceIdiom == .pad {
        dimension = UIScreen.main.bounds.size.width * 0.8
    }
}
func vibrate(){
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
