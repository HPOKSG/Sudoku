//
//  ProtocolHelper.swift
//  Sudoku
//
//  Created by Hữu Phước  on 04/09/2023.
//

import Foundation
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
    func convertStringToNestedBoolArray()->[[Bool]]{
        var booleanArray : [[Bool]] = []
        for i in stride(from: 0, to: self.count, by: 9) {
            var row = [Bool]()
            let startIndex = self.index(self.startIndex, offsetBy: i)
            let endIndex = self.index(self.startIndex, offsetBy: i + 9)
            let substring = self[startIndex..<endIndex]
            
            for char in substring {
                // Convert '0' to false and '1' to true
                let booleanValue = char == "1"
                row.append(booleanValue)
            }
            booleanArray.append(row)
        }
        return booleanArray
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
extension [[Bool]]{
    func convertToFlatString()->String{
        let flatString = self.flatMap { row in
            row.map { $0 ? "1" : "0" }
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
