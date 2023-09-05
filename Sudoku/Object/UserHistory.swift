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

class UserHistory: ObservableObject{
    @Published var currentUser: String
    
    @Published var userDetail: [UserDetail]{
        didSet{
            Self.userDetailStorage = userDetail
        }
    }
    
    @AppStorage ("userDetailStorage") static var userDetailStorage: [UserDetail] = UserList()
    
    @AppStorage ("lastUser") static var lastUser = ""
    
    init() {
//        Self.userDetailStorage = [user1,user2,user3]
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

    func increaseGameCount(mode: GameMode){
        var search = userDetail.first { user in
            user.name == currentUser
        }
        if (mode == .easy){
            search!.totalGameEasy += 1
        }else  if (mode == .easy){
            search!.totalGameMedium += 1
        } else{
            search!.totalGameHard += 1
        }
    }
    
    func increaseGameCountWhenContinue(mode: GameMode){
        if currentUser != Self.lastUser{
            var search = userDetail.first { user in
                user.name == currentUser
            }
            if (mode == .easy){
                search!.totalGameEasy += 1
            }else  if (mode == .easy){
                search!.totalGameMedium += 1
            } else{
                search!.totalGameHard += 1
            }
        }
    }
    
    func updateUserEasy(mode: GameMode, point: Int, time: Int){
        var searchedUser  = userDetail.first { user in
            user.name == currentUser
        }!
        
        if searchedUser.totalGameEasyWon == 5 {
            searchedUser.badge += "\(BadgeImage.allEasy.rawValue),"
        }
        
        //increase the game won count
        searchedUser.totalGameEasyWon += 1
        // if the user first Win Easy Mode then just set it
        if searchedUser.bestTimeEasy == 0 {
            searchedUser.bestTimeEasy = time
        }else{
            // if the new time is sooner than the current best then set it
            if searchedUser.bestTimeEasy > time{
                searchedUser.bestTimeEasy = time
            }
        }
        searchedUser.averageTimeEasy = (searchedUser.averageTimeEasy * (searchedUser.totalGameEasy - 1) + time ) / searchedUser.totalGameEasy
        
        if searchedUser.bestScoreEasy == 0 {
            searchedUser.bestScoreEasy = point
        }else{
            // if the new time is sooner than the current best then set it
            if searchedUser.bestScoreEasy > point{
                searchedUser.bestScoreEasy = point
            }
        }
        searchedUser.averageScoreEasy = (searchedUser.averageScoreEasy * (searchedUser.totalGameEasy - 1) + point ) / searchedUser.totalGameEasy
    }
    
    func updateUserMedium(mode: GameMode, point: Int, time: Int){
        var searchedUser  = userDetail.first { user in
            user.name == currentUser
        }!
        
        if searchedUser.totalGameMedium == 5 {
            searchedUser.badge += "\(BadgeImage.allMedium.rawValue),"
        }
        
        //increase the game won count
        searchedUser.totalGameMediumWon += 1
        // if the user first Win Easy Mode then just set it
        if searchedUser.bestTimeMedium == 0 {
            searchedUser.bestTimeMedium = time
        }else{
            // if the new time is sooner than the current best then set it
            if searchedUser.bestTimeMedium > time{
                searchedUser.bestTimeMedium = time
            }
        }
        searchedUser.averageTimeMedium = (searchedUser.averageTimeMedium * (searchedUser.totalGameMedium - 1) + time ) / searchedUser.totalGameMedium
        
        if searchedUser.bestScoreMedium == 0 {
            searchedUser.bestScoreMedium = point
        }else{
            // if the new time is sooner than the current best then set it
            if searchedUser.bestScoreMedium > point{
                searchedUser.bestScoreMedium = point
            }
        }
        searchedUser.averageScoreMedium = (searchedUser.averageScoreMedium * (searchedUser.totalGameMedium - 1) + point ) / searchedUser.totalGameMedium
    }
    
    func updateUserHard(mode: GameMode, point: Int, time: Int){
        var searchedUser  = userDetail.first { user in
            user.name == currentUser
        }!
        
        if searchedUser.totalGameHard == 1 {
            searchedUser.badge += "\(BadgeImage.firstGameHard.rawValue),"
        }
        if searchedUser.totalGameHardWon == 5 {
            searchedUser.badge += "\(BadgeImage.allHard.rawValue),"
        }
    
        //increase the game won count
        searchedUser.totalGameHardWon += 1
        // if the user first Win Easy Mode then just set it
        if searchedUser.bestTimeHard == 0 {
            searchedUser.bestTimeHard = time
        }else{
            // if the new time is sooner than the current best then set it
            if searchedUser.bestTimeHard > time{
                searchedUser.bestTimeHard = time
            }
        }
        searchedUser.averageTimeHard = (searchedUser.averageTimeHard * (searchedUser.totalGameHard - 1) + time ) / searchedUser.totalGameHard
        
        if searchedUser.bestScoreHard == 0 {
            searchedUser.bestScoreHard = point
        }else{
            // if the new time is sooner than the current best then set it
            if searchedUser.bestScoreHard > point{
                searchedUser.bestScoreHard = point
            }
        }
        searchedUser.averageScoreHard = (searchedUser.averageScoreHard * (searchedUser.totalGameHard - 1) + point ) / searchedUser.totalGameHard
    }
    
    
    //update user detail again when they won the map
    func updateUserDetail(mode: GameMode, point: Int, time: Int){
        
        if (time <= 500){
            var searchedUser  = userDetail.first { user in
                user.name == currentUser
            }!
            var badges = searchedUser.name.components(separatedBy: ",")
            if (!badges.contains(BadgeImage.fast.rawValue)){
                searchedUser.badge += "\(BadgeImage.fast.rawValue),"
            }
        }
        
        if mode == .easy{
            updateUserEasy(mode: mode, point: point, time: time)
        }else if mode == .medium{
            updateUserMedium(mode: mode, point: point, time: time)
        }else if mode == .hard{
            updateUserHard(mode: mode, point: point, time: time)
        }
    }
}

enum BadgeImage : String{
    
    var name: String {
            switch self {
            case .allEasy:
                return "Sudoku Savant"
            case .allHard:
                return "Elite Enigma Expert"
            case .allMedium:
                return "Puzzle Prodigy"
            case .fast:
                return "Speed Demon"
            case .firstGame:
                return "Rookie's Triumph"
            case .firstGameHard:
                return "Hardcore Sudoku Samurai"
            }
        }
    
    case allEasy = "allEasy"
    case allHard = "allHard"
    case allMedium = "allMedium"
    case fast = "fastIcon"
    case firstGame = "firstGame"
    case firstGameHard = "firstGameHard"
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
    badge: "allEasy,firstGameHard,fastIcon"
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
