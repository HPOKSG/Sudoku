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
class StorageObject : ObservableObject{
   
    // 9x9 array to store shading information for cells
    @Published var shadedMap : [[String]] = Array(repeating: Array(repeating: "", count: 9), count: 9)
    
    // Array to store notes for each cell
    @Published var noteStorageArray: [[[Int]]]{
        didSet{
            Self.noteStorageArrayAppStorage = self.noteStorageArray.convertToFlatString()
        }
    }
    
    @Published var answerArray: [[Int]]{
        didSet{
            Self.answerArrayStorage = answerArray.convertToFlatString()
        }
    }
    
    // 2D array to track error status for cells
    @Published var errorTextMap: [[Bool]]{
        didSet{
            Self.errorTextMapStorage = self.errorTextMap.convertToFlatString()
        }
    }
    
    // 2D array to store initial pre-filled values
    @Published var preFilledArray : [[Int]]
    
    // 2D array to store initial pre-filled values
    @Published var indexMap : Int{
        didSet{
            Self.indexMapStorage = indexMap
        }
    }
    
    // 2D array representing the current state of the Sudoku puzzle
    @Published var currArray : [[Int]]{
        didSet{
            Self.currArrayAppStorage = currArray.convertToFlatString()
        }
    }
    
    // Elapsed time in seconds
    @Published var secondsElapsed : Int{
        didSet{
            Self.secondElapsedStorage = secondsElapsed
        }
    }
    
    // Current status of the Sudoku game (e.g., in-progress, solved, etc.)
    @Published var gameStatus : GameStatus{
        didSet{
            Self.gameStatusStorage = gameStatus.rawValue
        }
    }
    
    // 2D array to store the history of Sudoku puzzle changes
    @Published var historyMap : [[Int]]{
        didSet{
            Self.historyMapStorage = historyMap.convertToFlatString()
        }
    }
    
    // Game mode (easy, medium, hard)
    @Published var mode: GameMode{
        didSet{
            if mode == .easy{
                Self.gameModeStorage = GameMode.easy.rawValue
            }else if mode == .medium{
                Self.gameModeStorage = GameMode.medium.rawValue
            }else if mode == .hard{
                Self.gameModeStorage = GameMode.hard.rawValue
            }
            Self.gameModeStorage = GameMode.none.rawValue
        }
    }
    
    // Theme preference (light or dark)
    @Published var theme: Bool{
        didSet{
            Self.isLightTheme = theme
        }
    }
    
    @AppStorage ("indexMapStorage") static var indexMapStorage = -1 // App storage for game mode
    
    @AppStorage ("gameModeStorage") static var gameModeStorage = "" // App storage for game mode
    
    @AppStorage ("gameStatusStorage") static var gameStatusStorage = "" // App storage for game status
    
    @AppStorage ("isLightTheme") static var isLightTheme = true // App storage for theme preference (light/dark)
    
    @AppStorage ("secondElapsedStorage") static var secondElapsedStorage = 0 // App storage for elapsed seconds
    
    @AppStorage ("currPoint") static var currPoint = 0 // App storage for current points
    
    @AppStorage ("currMistake") static var  currMistake = 0 // App storage for current mistakes
    
    @AppStorage ("answerArrayStorage") static var answerArrayStorage = "000000000000000000000000000000000000000000000000000000000000000000000000000000000" // App storage for
     
    @AppStorage ("errorTextMapStorage") static var errorTextMapStorage = "000000000000000000000000000000000000000000000000000000000000000000000000000000000" // App storage for error text map
    
    @AppStorage ("preFilledArrayStorage") static var preFilledArrayStorage = "000000000000000000000000000000000000000000000000000000000000000000000000000000000" // App storage for pre-filled array
    
    @AppStorage ("historyMapStorage") static var historyMapStorage = "000000000000000000000000000000000000000000000000000000000000000000000000000000000" // App storage for history map
  
    @AppStorage ("currArrayAppStorage") static var currArrayAppStorage = "000000000000000000000000000000000000000000000000000000000000000000000000000000000" // App storage for current array
   
    @AppStorage ("noteStorageArrayAppStorage") static var noteStorageArrayAppStorage = "" // App storage for note storage array
    
    
    //Declare computed pointIncrement
    var pointIncrement: Int {
        if mode == .easy {
            return 100 // Points increment for easy mode
        } else if mode == .medium {
            return 150 // Points increment for medium mode
        } else if mode == .hard {
            return 175 // Points increment for hard mode
        }
        return -1
    }
    
    var maxAttemp: Int {
        if mode == .easy {
            return 10 // Maximum attempts for easy mode
        } else if mode == .medium {
            return 5 // Maximum attempts for medium mode
        } else if mode == .hard {
            return 3 // Maximum attempts for hard mode
        }
        return -1
    }
    
    init() {
        noteStorageArray = [] // Initialize note storage array
        
        errorTextMap = [] // Initialize error text map
        
        currArray = [] // Initialize current array
        
        historyMap = [] // Initialize history map
        
        preFilledArray = [] // Initialize pre-filled array
        
        answerArray = []
        
        indexMap = 0
        
        secondsElapsed = Self.secondElapsedStorage  // Initialize elapsed seconds
        
        mode = GameMode.getGameMode(Self.gameModeStorage) // Initialize game mode
        
        gameStatus = GameStatus.getGameStatus(Self.gameStatusStorage) // Initialize game status
        
        theme = Self.isLightTheme // Initialize theme preference
        
        answerArray = Self.answerArrayStorage.convertStringToNestedArray()
        
        historyMap = Self.historyMapStorage.convertStringToNestedArray() // Initialize history map from storage
        
        if Self.noteStorageArrayAppStorage.count > 0{
            noteStorageArray = Self.noteStorageArrayAppStorage.convertStringToNestedArrayComplex()  // Initialize note storage array from storage (if available)
        }else{
            for _ in 0..<9{
                var tempArray: [[Int]] = []
                for _ in 0..<9{
                    tempArray.append([])
                }
                noteStorageArray.append(tempArray)
            }
        }
        
        indexMap = Self.indexMapStorage
        
        errorTextMap = Self.errorTextMapStorage.convertStringToNestedBoolArray() // Initialize error text map from storage
    
        preFilledArray = Self.preFilledArrayStorage.convertStringToNestedArray() // Initialize pre-filled array from storage
        
        currArray = Self.currArrayAppStorage.convertStringToNestedArray() // Initialize error text map from storage
    }
    
    func insertNumToNoteArray(x: Int, y: Int, num: Int){
        // Function to insert a number into the noteStorageArray at the specified position (x, y)
        // If the number already exists in the array, it returns early.
        for item in noteStorageArray[x][y]{
            if item == num{
                return
            }
        }
        noteStorageArray[x][y].append(num)
    }
    
    func isValidMove(x: Int, y:Int) ->Bool{
        // Function to check if the current state of the Sudoku board (currArray) is a valid move.
        return currArray[x][y] == answerArray[x][y]
    }
    func resetShadedMap(){
        // Function to reset the shadedMap to an empty state.
        self.shadedMap = Array(repeating: Array(repeating: "", count: 9), count: 9)
    }
    func resetErrorTextMap(){
        // Function to reset the errorTextMap to an empty state.
        self.errorTextMap =  Array(repeating: Array(repeating: false, count: 9), count: 9)
    }
    
    func fillCell(x: Int, y: Int){
        // Function to fill a cell at position (x, y) and update the shadedMap to indicate shading.
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
        // Function to highlight cells with errors in the shadedMap.
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
    func setUpGame(mode: GameMode){
        // Function to set up a new game with the given mode and map
        self.mode = mode

        //set up map
        var map = ""
        var answerMap = ""
        indexMap = Int.random(in: 0...2)
        if let answerMaps = solutionMap[mode.rawValue], let maps = gameMap[mode.rawValue]{
            map = maps[indexMap]
            answerMap = answerMaps[indexMap]
        }
        // Update the game mode storage for persistence.
        Self.gameModeStorage = mode.rawValue
        
        // Reset various game-related properties.
        Self.currPoint = 0
        Self.currMistake = 0
        Self.gameStatusStorage = GameStatus.isPlaying.rawValue
        Self.secondElapsedStorage = 0
        Self.preFilledArrayStorage = map
        
        // Set the game status to 'isPlaying'.
        gameStatus = .isPlaying
        
        // Reset the seconds elapsed.
        secondsElapsed = 0
        
        // Reset the shadedMap.
        shadedMap = Array(repeating: Array(repeating: "", count: 9), count: 9)
        
        // Reset the noteStorageArray.
        self.noteStorageArray = []
        for _ in 0..<9{
            var tempArray: [[Int]] = []
            for _ in 0..<9{
                tempArray.append([])
            }
            noteStorageArray.append(tempArray)
        }
        
        // Reset the errorTextMap.
        errorTextMap =  Array(repeating: Array(repeating: false, count: 9), count: 9)
        answerArray = answerMap.convertStringToNestedArray()
        // Initialize the preFilledArray, currArray, and historyMap from the provided map string.
        preFilledArray = map.convertStringToNestedArray()
        currArray = map.convertStringToNestedArray()
        historyMap = map.convertStringToNestedArray()
    }
    
    func setGameStatus(_ value: GameStatus){
        // Function to set the game status to the specified value and update the storage.
        Self.gameStatusStorage = value.rawValue
    }
    
    func isNewValidMove(x : Int, y : Int) -> Bool{
        // Function to check if a move at the specified position (x, y) is a new valid move.
        if historyMap[x][y] == -1{
            historyMap[x][y] = currArray [x][y]
            return true
        }
        return false
    }
    
    func countCurrentNum(num : Int) -> Bool{
        // Function to count the occurrences of a number in the currArray.
        var count  = 0
        for i in  0..<9{
            for j in 0..<9{
                if currArray[i][j] == num{
                    count += 1
                }
                if count == 9{
                    return true
                }
            }
        }
        return false
    }
    
    func convertToTimer() -> String{
        // Function to convert the elapsed seconds into a timer format (MM:SS).
        let minute: Int = Self.secondElapsedStorage/60
        let second: Int =  Self.secondElapsedStorage%60
        
        let minuteInString = minute >= 10 ? String(minute) : "0\(minute)"
        let secondInstring = second >= 10 ? String(second) : "0\(second)"
        
        return  "\(minuteInString):\(secondInstring)"
    }
    func getCurrentGameStatus() -> GameStatus{
        // Function to retrieve the current game status.
        return GameStatus.getGameStatus(Self.gameStatusStorage)
    }
    func isWinning() -> Bool{
        // Function to check if the player has won the game by filling all cells correctly.
        for i in 0..<9{
            for j in 0..<9{
                if currArray[i][j] == -1{return false}
            }
        }
        gameStatus = .won
        return true
    }
    
    func isLoosing() -> Bool{
        // Function to check if the player has lost the game by exceeding the maximum allowed m
        if (Self.currMistake == self.maxAttemp){
            gameStatus = .lost
            return true
        }
        return false
    }
}

enum GameMode : String{
    // Enum defining different game modes and providing a method to get a GameMode from a raw string value.
    static func getGameMode(_ mode:String) -> GameMode{
        if mode == GameMode.easy.rawValue{
            return .easy
        }else  if mode == GameMode.medium.rawValue{
            return .medium
        }else if mode == GameMode.hard.rawValue{
            return .hard
        }
        return .none
    }
    
    var vietnamese: String {
            switch self {
            case .easy:
                return "Dễ"
            case .medium:
                return "Trung Bình"
            case .hard:
                return "Khó"
            case .none:
                return "Không"
            }
    }
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case none = "None"
}

enum GameStatus: String{
    static func getGameStatus(_ status: String) -> GameStatus{
        // Enum defining different game statuses and providing a method to get a GameStatus from a raw string value.
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
