/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 2
 Author: Dinh Gia Huu Phuoc
 ID: s3878270
 Created  date: 25/08/2023
 Last modified: 06/09/2023
 Acknowledgement: COSC2659 Lecture Slides, Apple IOS Development Tutorial
 */

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        
        ScrollView {
            VStack(spacing:30) {
                VStack (alignment: .leading){
                    Text("Sudoku Rule No 1: Use Numbers 1-9")
                        .bold()
                        .font(.title2)
                        .padding(.bottom)
                    
                    Text("\(firstRule)")
                        .bold()
                        .font(.title3)
                }
                .padding(.all)
                .background{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("itemStat"))
                }
                
                
                VStack (alignment: .leading){
                    Text("Sudoku Rule No 2: Don’t Repeat Any Numbers")
                        .bold()
                        .font(.title2)
                        .padding(.bottom)
                    
                    Text("\(secondRule)")
                        .bold()
                        .font(.title3)
                }
                .padding(.all)
                .background{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("itemStat"))
                }
                
                
                VStack (alignment: .leading){
                    Text("Sudoku Rule No 3: Don't Guess")
                        .bold()
                        .font(.title2)
                        .padding(.bottom)
                    
                    Text("\(thirdRule)")
                        .bold()
                        .font(.title3)
                }
                .padding(.all)
                .background{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color("itemStat"))
                }
            }
        }
        .padding(.all)
       
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
var firstRule = "Sudoku is played on a grid of 9 x 9 spaces. Within the rows and columns are 9 “squares” (made up of 3 x 3 spaces). Each row, column and square (9 spaces each) needs to be filled out with the numbers 1-9, without repeating any numbers within the row, column or square. Does it sound complicated? As you can see from the image below of an actual Sudoku grid, each Sudoku grid comes with a few spaces already filled in; the more spaces filled in, the easier the game – the more difficult Sudoku puzzles have very few spaces that are already filled in."

var secondRule = "As you can see, in the upper left square (circled in blue), this square already has 7 out of the 9 spaces filled in. The only numbers missing from the square are 5 and 6. By seeing which numbers are missing from each square, row, or column, we can use process of elimination and deductive reasoning to decide which numbers need to go in each blank space. For example, in the upper left square, we know we need to add a 5 and a 6 to be able to complete the square, but based on the neighboring rows and squares we cannot clearly deduce which number to add in which space. This means that we should ignore the upper left square for now, and try to fill in spaces in some other areas of the grid instead."

var thirdRule = "Sudoku is a game of logic and reasoning, so you shouldn’t have to guess. If you don’t know what number to put in a certain space, keep scanning the other areas of the grid until you seen an opportunity to place a number. But don’t try to “force” anything – Sudoku rewards patience, insights, and recognition of patterns, not blind luck or guessing."
