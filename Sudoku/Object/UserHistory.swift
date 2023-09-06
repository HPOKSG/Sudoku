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
    
    //declare the currentUser detail information
    @Published var currentUser: String
    
    @Published var userDetail: [UserDetail]{
        didSet{
            Self.userDetailStorage = userDetail
        }
    }
    
    //declare new Badge to display in winning view
    @Published var newBadageAdded: String
    
    //declare the AppStorage variable to store the currentUserSettting
    @AppStorage ("userDetailStorage") static var userDetailStorage: [UserDetail] = UserList()
    
    @AppStorage ("lastUser") static var lastUser = ""
    
    //init the UserHistory
    init() {
//        Self.userDetailStorage = UserList()
        userDetail = Self.userDetailStorage
        currentUser = ""
        newBadageAdded = ""
    }
    
   //delcare the sorting criteria to sort list user
    let sortingCriteria: [(String, (UserDetail, UserDetail) -> Bool)] = [
        ("rankingPoint", { user1, user2 in
            return user1.rankingPoint < user2.rankingPoint
        }),
        ("averageTime", { user1, user2 in
            return user1.averageTotalTime < user2.averageTotalTime
        })
    ]

    //declare storageObject, this will store the list of user in ranking order
    var sortedObjects: [UserDetail] {
        var temp = userDetail
        
        //return the sorted array
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
    
    //this function will insert the new user
    //with given currName with the default
    //setting of other fields are 0
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
        var user = userDetail.first { user in
            return user.name == currentUser
        }
        return user
    }
    
    //this function increase game count when
    //user start the name game
    func increaseGameCount(mode: GameMode){
        var index = userDetail.firstIndex { $0.name == currentUser}
        //detect the mode and do increment
        if (mode == .easy){
            userDetail[index!].totalGameEasy += 1
        }else  if (mode == .medium){
            userDetail[index!].totalGameMedium += 1
        } else{
            userDetail[index!].totalGameHard += 1
        }
    }
    
    //this function also increase the game count if
    //the new user click on the contineu button
    func increaseGameCountWhenContinue(mode: GameMode){
        if currentUser != Self.lastUser{
            var index = userDetail.firstIndex { $0.name == currentUser}
            //detect the mode and do increment
            if (mode == .easy){
                userDetail[index!].totalGameEasy += 1
            }else  if (mode == .easy){
                userDetail[index!].totalGameMedium += 1
            } else{
                userDetail[index!].totalGameHard += 1
            }
        }
    }
    
    //update user information after they win easy mode game
    func updateUserEasy(mode: GameMode, point: Int, time: Int){
        var index = userDetail.firstIndex { $0.name == currentUser}
        
        //increase the game won count
        userDetail[index!].totalGameEasyWon += 1
        
        if userDetail[index!].totalGameEasyWon == 3{
            let _ = print ("Add game easy won")
            userDetail[index!].badge += "\(BadgeImage.allEasy.rawValue),"
            newBadageAdded += "\(BadgeImage.allEasy.rawValue),"
        }
        
      
        // if the user first Win Easy Mode then just set it
        if userDetail[index!].bestTimeEasy == 0 {
            userDetail[index!].bestTimeEasy = time
        }else{
            // if the new time is sooner than the current best then set it
            if userDetail[index!].bestTimeEasy > time{
                userDetail[index!].bestTimeEasy = time
            }
        }
        
        if userDetail[index!].totalGameEasy > 0{
            userDetail[index!].averageTimeEasy = (userDetail[index!].averageTimeEasy * (userDetail[index!].totalGameEasy - 1) + time ) / userDetail[index!].totalGameEasy
            userDetail[index!].averageScoreEasy = (userDetail[index!].averageScoreEasy * (userDetail[index!].totalGameEasy - 1) + point ) / userDetail[index!].totalGameEasy
        }
        
        if userDetail[index!].bestScoreEasy == 0 {
            userDetail[index!].bestScoreEasy = point
        }else{
            // if the new time is sooner than the current best then set it
            if userDetail[index!].bestScoreEasy > point{
                userDetail[index!].bestScoreEasy = point
            }
        }
       
    }
    
    //update user information after they win medium mode game
    func updateUserMedium(mode: GameMode, point: Int, time: Int){
        var index = userDetail.firstIndex { $0.name == currentUser}
        
        //increase the game won count
        userDetail[index!].totalGameMediumWon += 1
        
        if userDetail[index!].totalGameMedium == 3 {
            userDetail[index!].badge += "\(BadgeImage.allMedium.rawValue),"
            newBadageAdded += "\(BadgeImage.allMedium.rawValue),"
        }
        
        
        // if the user first Win Easy Mode then just set it
        if userDetail[index!].bestTimeMedium == 0 {
            userDetail[index!].bestTimeMedium = time
        }else{
            // if the new time is sooner than the current best then set it
            if userDetail[index!].bestTimeMedium > time{
                userDetail[index!].bestTimeMedium = time
            }
        }
        
        if userDetail[index!].totalGameMedium > 0 {
            userDetail[index!].averageScoreMedium = (userDetail[index!].averageScoreMedium * (userDetail[index!].totalGameMedium - 1) + point ) / userDetail[index!].totalGameMedium
            userDetail[index!].averageTimeMedium = (userDetail[index!].averageTimeMedium * (userDetail[index!].totalGameMedium - 1) + time ) / userDetail[index!].totalGameMedium
        }
        
        if userDetail[index!].bestScoreMedium == 0 {
            userDetail[index!].bestScoreMedium = point
        }else{
            // if the new time is sooner than the current best then set it
            if userDetail[index!].bestScoreMedium > point{
                userDetail[index!].bestScoreMedium = point
            }
        }
    }
        
    //update user information after they win hard mode game
    func updateUserHard(mode: GameMode, point: Int, time: Int){
        var index = userDetail.firstIndex { $0.name == currentUser}
        
        //increase the game won count
        userDetail[index!].totalGameHard += 1
        
        if  userDetail[index!].totalGameHardWon == 5 {
            userDetail[index!].badge += "\(BadgeImage.allHard.rawValue),"
            newBadageAdded += "\(BadgeImage.allHard.rawValue),"
        }
    
        //increase the game won count
        userDetail[index!].totalGameHardWon += 1
        // if the user first Win Easy Mode then just set it
        if  userDetail[index!].bestTimeHard == 0 {
            userDetail[index!].bestTimeHard = time
        }else{
            // if the new time is sooner than the current best then set it
            if  userDetail[index!].bestTimeHard > time{
                userDetail[index!].bestTimeHard = time
            }
        }
        
        if  userDetail[index!].totalGameHard > 0 {
            userDetail[index!].averageTimeHard = ( userDetail[index!].averageTimeHard * ( userDetail[index!].totalGameHard - 1) + time ) /  userDetail[index!].totalGameHard
            userDetail[index!].averageScoreHard = ( userDetail[index!].averageScoreHard * ( userDetail[index!].totalGameHard - 1) + point ) /  userDetail[index!].totalGameHard
        }
        
        if  userDetail[index!].bestScoreHard == 0 {
            userDetail[index!].bestScoreHard = point
        }else{
            // if the new time is sooner than the current best then set it
            if  userDetail[index!].bestScoreHard > point{
                userDetail[index!].bestScoreHard = point
            }
        }
        
    }
    
    
    //update user detail again when they won the map
    func updateUserDetail(mode: GameMode, point: Int, time: Int){
        var index = userDetail.firstIndex { $0.name == currentUser}
        if (time <= 500){
            if (!userDetail[index!].badge.contains(BadgeImage.fast.rawValue)){
                let _ = print ("add fast badge")
                userDetail[index!].badge += "\(BadgeImage.fast.rawValue),"
                newBadageAdded += "\(BadgeImage.fast.rawValue),"
            }
        }
        
        if mode == .easy{
            updateUserEasy(mode: mode, point: point, time: time)
        }else if mode == .medium{
            updateUserMedium(mode: mode, point: point, time: time)
        }else if mode == .hard{
            updateUserHard(mode: mode, point: point, time: time)
        }
        let _ = print ("\(userDetail[index!])")
        let _ = print ("\(newBadageAdded)")
        
    }
}

//declare BadgameImage to store badge name with
//the image name for easy accessing
enum BadgeImage : String{
    
    static func getBadgeView(_ value: String)->BadgeImage{
        if value ==  BadgeImage.allEasy.rawValue{
            return .allEasy
        }else if value ==  BadgeImage.allMedium.rawValue{
            return .allMedium
        }
        else if value ==  BadgeImage.allHard.rawValue{
            return .allHard
        }
        else if value ==  BadgeImage.fast.rawValue{
            return .fast
        }
        else if value ==  BadgeImage.firstGame.rawValue{
            return .firstGame
        }
        else if value ==  BadgeImage.firstGameHard.rawValue{
            return .firstGameHard
        }
        return .fast
    }
    
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
