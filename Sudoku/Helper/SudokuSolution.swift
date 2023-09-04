//
//  SudokuSolution.swift
//  Sudoku
//
//  Created by Hữu Phước  on 31/08/2023.
//

import Foundation


class SudokuSolution {
    static func checkRow(board:[[Int]],i: Int, j:Int, input: Int) -> Bool{
        for k in 0..<9{
            if (board[i][k] == input && k != j){return false}
        }
        return true
    }
    
    static func checkColumn(board:[[Int]],i: Int, j:Int, input: Int) -> Bool{
        for k in 0..<9{
            if (board[k][j] == input && k != i){return false}
        }
        return true
    }
    
    static func checkBox(board:[[Int]],i: Int, j:Int, input: Int) -> Bool{
        var baseRow = i - i%3
        var baseCol = j - j%3
        
        for k in baseRow..<baseRow+3{
            for l in baseCol..<baseCol+3{
                if (board[k][l] == input && k != i && l != j){return false}
            }
        }
        return true
    }
    
    static func isValidSudoku(board: [[Int]]) -> Bool {
        for i in 0..<board.count{
            for j in 0..<board[0].count{
                let input = board[i][j]
                if input != -1 {
                    if (
                        !checkRow(board: board,i: i,j: j,input: input) ||
                        !checkColumn(board: board,i: i,j: j,input: input) ||
                        !checkBox(board: board,i: i,j: j,input: input)
                     
                    )
                    {
                        return false;
                    }
                }
            }
        }
        return true;
    }
}
