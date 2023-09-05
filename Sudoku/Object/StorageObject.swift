//
//  NoteStorageObject.swift
//  Sudoku
//
//  Created by Hữu Phước  on 24/08/2023.
//

import Foundation
import SwiftUI
class StorageObject : ObservableObject{
   
    @Published var shadedMap : [[String]] = Array(repeating: Array(repeating: "", count: 9), count: 9)
    
    @Published var noteStorageArray: [[[Int]]]{
        didSet{
            Self.noteStorageArrayAppStorage = self.noteStorageArray.convertToFlatString()
        }
    }
    @Published var errorTextMap: [[Bool]]{
        didSet{
            Self.errorTextMapStorage = self.errorTextMap.convertToFlatString()
        }
    }
    
    @Published var preFilledArray : [[Int]]
    
    @Published var currArray : [[Int]]{
        didSet{
            Self.currArrayAppStorage = currArray.convertToFlatString()
        }
    }
    
    @Published var secondsElapsed : Int{
        didSet{
            Self.secondElapsedStorage = secondsElapsed
        }
    }
    
    @Published var gameStatus : GameStatus{
        didSet{
            Self.gameStatusStorage = gameStatus.rawValue
        }
    }
    
    
    @Published var mode: GameMode{
        didSet{
            if mode == .easy{
                Self.gameModeStorage = "easy"
            }else if mode == .medium{
                Self.gameModeStorage = "medium"
            }else if mode == .hard{
                Self.gameModeStorage = "hard"
            }
            Self.gameModeStorage = "none"
        }
    }
    
    @Published var theme: Bool{
        didSet{
            Self.isLightTheme = theme
        }
    }
    
    @AppStorage ("gameModeStorage") static var gameModeStorage = ""
    
    @AppStorage ("gameStatusStorage") static var gameStatusStorage = ""
    
    @AppStorage ("isLightTheme") static var isLightTheme = true
    
    @AppStorage ("secondElapsedStorage") static var secondElapsedStorage = 0
    
    @AppStorage ("currPoint") static var currPoint = 0
    
    @AppStorage ("currMistake") static var  currMistake = 0
    
    @AppStorage ("errorTextMapStorage") static var errorTextMapStorage = "000000000000000000000000000000000000000000000000000000000000000000000000000000000"
    
    @AppStorage ("preFilledArrayStorage") static var preFilledArrayStorage = "000000000000000000000000000000000000000000000000000000000000000000000000000000000"
  
    @AppStorage ("currArrayAppStorage") static var currArrayAppStorage = "000000000000000000000000000000000000000000000000000000000000000000000000000000000"
   
    @AppStorage ("noteStorageArrayAppStorage") static var noteStorageArrayAppStorage = ""
   
    var pointIncrement: Int{
        if mode == .easy{
            return 100
        }else if mode == .medium{
            return 150
        }else if mode == .hard{
            return 175
        }
        return -1
    }
    
    var maxAttemp: Int{
        if mode == .easy{
            return 10
        }else if mode == .medium{
            return 5
        }else if mode == .hard{
            return 3
        }
        return -1
    }
    init() {
        noteStorageArray = []
        
        errorTextMap = []
        
        currArray = []
        
        preFilledArray = []
        
        secondsElapsed = Self.secondElapsedStorage
        
        mode = GameMode.getGameMode(Self.gameModeStorage)
        
        gameStatus = GameStatus.getGameStatus(Self.gameStatusStorage)
        
        theme = Self.isLightTheme
        
        if Self.noteStorageArrayAppStorage.count > 0{
            noteStorageArray = Self.noteStorageArrayAppStorage.convertStringToNestedArrayComplex()
        }else{
            for _ in 0..<9{
                var tempArray: [[Int]] = []
                for _ in 0..<9{
                    tempArray.append([])
                }
                noteStorageArray.append(tempArray)
            }
        }
        
        errorTextMap = Self.errorTextMapStorage.convertStringToNestedBoolArray()
    
        preFilledArray = Self.preFilledArrayStorage.convertStringToNestedArray()
        
        currArray = Self.currArrayAppStorage.convertStringToNestedArray()
    }
    
    
    
    func insertNumToNoteArray(x: Int, y: Int, num: Int){
        for item in noteStorageArray[x][y]{
            if item == num{
                return
            }
        }
        noteStorageArray[x][y].append(num)
    }
    
    func isValidMove() ->Bool{
        return SudokuSolution.isValidSudoku(board: self.currArray)
    }
    func resetShadedMap(){
        self.shadedMap = Array(repeating: Array(repeating: "", count: 9), count: 9)
    }
    func resetErrorTextMap(){
        self.errorTextMap =  Array(repeating: Array(repeating: false, count: 9), count: 9)
    }
    func fillCell(x: Int, y: Int){
        resetShadedMap()
        for index in 0..<9{
            shadedMap[x][index] = "shaded"
        }
        for index in 0..<9{
            shadedMap[index][y] = "shaded"
        }
        let subgridStartX = (x / 3) * 3
        let subgridStartY = (y / 3) * 3
        
        for row in subgridStartX..<subgridStartX + 3 {
            for col in subgridStartY..<subgridStartY + 3 {
                shadedMap[row][col] = "shaded"
            }
        }
        let temp = currArray[x][y]
        if (temp != -1){
            for i in 0..<9{
                for j in 0..<9{
                    if currArray[i][j] == temp{
                        shadedMap[i][j] = "similarNumberColor"
                    }
                }
            }
        }
        shadedMap[x][y] = "highlight"
    }
    func highlightErorCell(x: Int, y: Int){
        for index in 0..<9{
            if currArray[x][index] ==  currArray[x][y]{
                shadedMap[x][index] = "error"
            }
                
        }
        for index in 0..<9{
            if currArray[index][y] ==  currArray[x][y]{
                shadedMap[index][y] = "error"
            }
        }
        let subgridStartX = (x / 3) * 3
        let subgridStartY = (y / 3) * 3
        
        for row in subgridStartX..<subgridStartX + 3 {
            for col in subgridStartY..<subgridStartY + 3 {
                if currArray[row][col] ==  currArray[x][y]{
                    shadedMap[row][col] = "error"
                }
            }
        }
        shadedMap[x][y] = "highlight"
        
        errorTextMap[x][y] = true
    
    }
    func setUpGame(mode: GameMode, map: String){
        self.mode = mode
        
        Self.gameModeStorage = mode.rawValue
        
        Self.currPoint = 0
        
        Self.currMistake = 0
        
        Self.gameStatusStorage = GameStatus.isPlaying.rawValue
        
        Self.secondElapsedStorage = 0
        
        gameStatus = .isPlaying
        
        secondsElapsed = 0
        
        shadedMap = Array(repeating: Array(repeating: "", count: 9), count: 9)
        
        self.noteStorageArray = []
        
        for _ in 0..<9{
            var tempArray: [[Int]] = []
            for _ in 0..<9{
                tempArray.append([])
            }
            noteStorageArray.append(tempArray)
        }
        
        errorTextMap =  Array(repeating: Array(repeating: false, count: 9), count: 9)
        
        preFilledArray = map.convertStringToNestedArray()
        
        Self.preFilledArrayStorage = map
        
        currArray = map.convertStringToNestedArray()
    }
    
    func setGameStatus(_ value: GameStatus){
        Self.gameStatusStorage = value.rawValue
    }
    
    func convertToTimer() -> String{
        let minute: Int = Self.secondElapsedStorage/60
        let second: Int =  Self.secondElapsedStorage%60
        
        let minuteInString = minute >= 10 ? String(minute) : "0\(minute)"
        let secondInstring = second >= 10 ? String(second) : "0\(second)"
        
        return  "\(minuteInString):\(secondInstring)"
    }
    func getCurrentGameStatus() -> GameStatus{
        return GameStatus.getGameStatus(Self.gameStatusStorage)
    }
    func isWinning(){
        for i in 0..<9{
            for j in 0..<9{
                if currArray[i][j] == -1{return}
            }
        }
        if isValidMove(){
            gameStatus = .won
        }
    }
    
    func isLoosing(){
       
        if (Self.currMistake == self.maxAttemp){
           
            gameStatus = .lost
        }
    }
}

enum GameMode : String{
    static func getGameMode(_ mode:String) -> GameMode{
        if mode == GameMode.easy.rawValue{
            return .easy
        }else  if mode == GameMode.medium.rawValue{
            return .medium
        }else if mode == GameMode.hard.rawValue{
            return .hard
        }
        let _ = print ("return none")
        return .none
    }
    
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case none = "None"
}
enum GameStatus: String{
    static func getGameStatus(_ status: String) -> GameStatus{
        if status == GameStatus.isPlaying.rawValue{
            return .isPlaying
        }else if status == GameStatus.won.rawValue{
            return .won
        }else if status == GameStatus.lost.rawValue{
            return .lost
        }else if status == GameStatus.pause.rawValue{
            return .pause
        }
        return .none
    }
    
    case isPlaying = "isPlaying"
    case pause = "pause"
    case won = "won"
    case lost = "lost"
    case none = "Unknown"
}
