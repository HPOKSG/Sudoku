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

struct UserDetail: Codable, Identifiable {
    //declare id for Identifiable
    let id: UUID
    
    //declare all the field related to the user
    var name: String
    
    var totalGameEasy: Int
    
    var totalGameMedium: Int
    
    var totalGameHard: Int
    
    var totalGameEasyWon: Int
    
    var totalGameMediumWon: Int
    
    var totalGameHardWon: Int

    //delcare best time vairables
    var bestTimeEasy:Int
    
    var bestTimeMedium:Int
    
    var bestTimeHard:Int

    //decleare average time variables for different mode
    var averageTimeEasy:Int
    
    var averageTimeMedium:Int
    
    var averageTimeHard:Int
    
    //declare computed averageToalTime
    var averageTotalTime : Int {
        return (averageTimeEasy + averageTimeMedium + averageTimeHard) / 3
    }
    
    //declare best score for each mode
    var bestScoreEasy: Int
    
    var bestScoreMedium: Int
    
    var bestScoreHard: Int
    
    //declare average score
    var averageScoreEasy: Int
    
    var averageScoreMedium: Int
    
    var averageScoreHard: Int
    
    var averageTotalScore : Int {
        return (averageScoreEasy + averageScoreMedium + averageScoreHard) / 3
    }
    
    var rankingPoint: Double {
        return Double(totalGameHard) * 2.0 + Double(totalGameMedium) * 1.5 + Double(totalGameEasy)
    }

    //badgeEarn
    var badge: String
}

//declare typeAlisas for UserDetail Array
typealias UserList = [UserDetail]

//declare the extension to store custome struct object
extension UserList: RawRepresentable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
            let result = try? JSONDecoder().decode(UserList.self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
            let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}


