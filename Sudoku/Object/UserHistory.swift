//
//  UserHistory.swift
//  Sudoku
//
//  Created by Hữu Phước  on 05/09/2023.
//

import Foundation
import SwiftUI

class UserHistory: ObservableObject{
    @Published var currentUser: String
    
    @Published var userDetail: [UserDetail]{
        didSet{
            Self.userDetailStorage = userDetail
        }
    }
    
    @AppStorage ("userDetailStorage") static var userDetailStorage: [UserDetail] = UserList()
    
    init() {
        Self.userDetailStorage = [user1,user2,user3]
        userDetail = Self.userDetailStorage
        currentUser = ""
    }
    
   
    let sortingCriteria: [(String, (UserDetail, UserDetail) -> Bool)] = [
        ("rankingPoint", { user1, user2 in
            return user1.rankingPoint < user2.rankingPoint
        }),
        ("averageTime", { user1, user2 in
            return user1.averageTotalTime < user2.averageTotalTime
        })
    ]

    
    var sortedObjects: [UserDetail] {
        var temp = userDetail

        return temp.sorted { user1, user2 in
            for (label, comparator) in sortingCriteria {
                if label == "rankingPoint" {
                    // Sort rankingPoint in descending order
                    if comparator(user1, user2) {
                        return false
                    } else if comparator(user2, user1) {
                        return true
                    }
                } else if label == "averageTime" {
                    // Sort averageTime in ascending order
                    if comparator(user1, user2) {
                        return true
                    } else if comparator(user2, user1) {
                        return false
                    }
                }
            }
            return false // If all criteria are equal, maintain the original order
        }
    }
    func insertNewUser() {
        let newUser = UserDetail(
            id: UUID(),
            name: currentUser,
            totalGameEasy: 0,
            totalGameMedium: 0,
            totalGameHard: 0,
            totalGameEasyWon: 0,
            totalGameMediumWon: 0,
            totalGameHardWon: 0,
            bestTimeEasy: 0,
            bestTimeMedium: 0,
            bestTimeHard: 0,
            averageTimeEasy: 0,
            averageTimeMedium: 0,
            averageTimeHard: 0,
            bestScoreEasy: 0,
            bestScoreMedium: 0,
            bestScoreHard: 0,
            averageScoreEasy: 0,
            averageScoreMedium: 0,
            averageScoreHard: 0,
            badge: ""
        )
        
        userDetail.append(newUser)
    }
    
    func doesUserExist() -> Bool {
        // Check if a user with the same name already exists
        return userDetail.contains { user in
            return user.name == currentUser
        }
    }
    func getCurrentUser() -> UserDetail? {
        // Iterate through userDetail to find the user with the specified userID
        return userDetail.first { user in
            return user.name == currentUser
        }
    }



    
}

let user1 = UserDetail(
    id: UUID(),
    name: "User1",
    totalGameEasy: 5,
    totalGameMedium: 5,
    totalGameHard: 5,
    totalGameEasyWon: 2,
    totalGameMediumWon: 3,
    totalGameHardWon: 4,
    bestTimeEasy: 175,
    bestTimeMedium: 200,
    bestTimeHard: 250,
    averageTimeEasy: 180,
    averageTimeMedium: 210,
    averageTimeHard: 255,
    bestScoreEasy: 4,
    bestScoreMedium: 3,
    bestScoreHard: 5,
    averageScoreEasy: 3,
    averageScoreMedium: 4,
    averageScoreHard: 4,
    badge: "GoldBadge1"
)

let user2 = UserDetail(
    id: UUID(),
    name: "User2",
    totalGameEasy: 2,
    totalGameMedium: 3,
    totalGameHard: 4,
    totalGameEasyWon: 1,
    totalGameMediumWon: 2,
    totalGameHardWon: 3,
    bestTimeEasy: 160,
    bestTimeMedium: 190,
    bestTimeHard: 220,
    averageTimeEasy: 165,
    averageTimeMedium: 195,
    averageTimeHard: 225,
    bestScoreEasy: 3,
    bestScoreMedium: 2,
    bestScoreHard: 4,
    averageScoreEasy: 2,
    averageScoreMedium: 3,
    averageScoreHard: 3,
    badge: "SilverBadge2"
)

let user3 = UserDetail(
    id: UUID(),
    name: "User3",
    totalGameEasy: 5,
    totalGameMedium: 5,
    totalGameHard: 5,
    totalGameEasyWon: 5,
    totalGameMediumWon: 5,
    totalGameHardWon: 5,
    bestTimeEasy: 300,
    bestTimeMedium: 300,
    bestTimeHard: 300,
    averageTimeEasy: 300,
    averageTimeMedium: 300,
    averageTimeHard: 300,
    bestScoreEasy: 5,
    bestScoreMedium: 5,
    bestScoreHard: 5,
    averageScoreEasy: 5,
    averageScoreMedium: 5,
    averageScoreHard: 5,
    badge: "PlatinumBadge3"
)
