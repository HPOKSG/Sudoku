//
//  NoteStorageObject.swift
//  Sudoku
//
//  Created by Hữu Phước  on 24/08/2023.
//

import Foundation
import SwiftUI
class StorageObject : ObservableObject{
   
    @Published var noteStorageArray: [[[Int]]]{
        didSet{
            Self.noteStorageArrayAppStorage = self.noteStorageArray.convertToFlatString()
        }
    }
    @Published var preFilledArray : [[Int]]
    @Published var currArray : [[Int]]{
        didSet{
            Self.currArrayAppStorage = currArray.convertToFlatString()
        }
    }
    
    @AppStorage ("preFilledArrayStorage") static var preFilledArrayStorage = "000000000000000000000000000000000000000000000000000000000000000000000000000000009"
  
    @AppStorage ("currArrayAppStorage") static var currArrayAppStorage = "000000000000000000000000000000000000000000000000000000000000000000000000000000009"
   
    @AppStorage ("noteStorageArrayAppStorage") static var noteStorageArrayAppStorage = ""
   
    
    init() {
       
        preFilledArray = Self.preFilledArrayStorage.convertStringToNestedArray()
        currArray = Self.currArrayAppStorage.convertStringToNestedArray()
        self.noteStorageArray = []
        for _ in 0..<9{
            var tempArray: [[Int]] = []
            for _ in 0..<9{
                tempArray.append([])
            }
            noteStorageArray.append(tempArray)
        }
            
//        if Self.noteStorageArrayAppStorage.isEmpty{
//            self.noteStorageArray = []
//            for _ in 0..<9{
//                var tempArray: [[Int]] = []
//                for _ in 0..<9{
//                    tempArray.append([])
//                }
//                noteStorageArray.append(tempArray)
//            }
//        }else{
//            noteStorageArray = Self.noteStorageArrayAppStorage.convertStringToNestedArrayComplex()
//        }
       
        
    }
    
    func insertNumToNoteArray(x: Int, y: Int, num: Int){
        for item in noteStorageArray[x][y]{
            if item == num{
                return
            }
        }
        noteStorageArray[x][y].append(num)
    }
    
  
    
}
extension String{
    func convertStringToNestedArray()->[[Int]]{
        var answer: [[Int]] = []
        for i in stride(from: 0, to: self.count, by: 9) {
            let startIndex = self.index(self.startIndex, offsetBy: i)
            let endIndex = self.index(startIndex, offsetBy: 9)
            let rowString = self[startIndex..<endIndex]
            let row = rowString.map { $0 == "0" ? -1 : Int(String($0))! }
            answer.append(row)
        }
        return answer
    }
    func convertStringToNestedArrayComplex()->[[[Int]]]{
        let temp = self
        if let temp = temp.data(using: .utf8) {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: temp, options: []) as? [[[Int]]] {
                  return jsonArray
                }
            } catch {
                print("Error parsing JSON:", error)
            }
        }
        return [[[-1]]]
    }
}
extension [[Int]]{
    func convertToFlatString()->String{
        let flatString = self.flatMap { row in
            row.map { $0 == -1 ? "0" : "\($0)" }
        }.joined()
        return flatString
    }
}
extension [[[Int]]]{
    func convertToFlatString()->String{
        var jsonString = "[\n"
        for outerArray in self {
            jsonString += "    ["
            for middleArray in outerArray {
                jsonString += "["
                for innerValue in middleArray {
                    jsonString += "\(innerValue),"
                }
                jsonString += "],"
            }
            jsonString += "],\n"
        }
        jsonString += "]"
        return jsonString
    }
}
