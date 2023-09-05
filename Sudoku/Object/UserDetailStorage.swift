//
//  UserDetailStorage.swift
//  Sudoku
//
//  Created by Hữu Phước  on 05/09/2023.
//

import Foundation

struct UserDetail: Codable, Identifiable {
    let id: UUID
    
    var name: String
    
    var totalGameEasy: Int
    
    var totalGameMedium: Int
    
    var totalGameHard: Int
    
    var totalGameEasyWon: Int
    
    var totalGameMediumWon: Int
    
    var totalGameHardWon: Int

    //best time
    var bestTimeEasy:Int
    
    var bestTimeMedium:Int
    
    var bestTimeHard:Int

    //average time
    var averageTimeEasy:Int
    
    var averageTimeMedium:Int
    
    var averageTimeHard:Int
    
    
    var averageTotalTime : Int {
        return (averageTimeEasy + averageTimeMedium + averageTimeHard) / 3
    }
    
    //best score
    var bestScoreEasy: Int
    
    var bestScoreMedium: Int
    
    var bestScoreHard: Int
    
    //average score
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

typealias UserList = [UserDetail]
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


