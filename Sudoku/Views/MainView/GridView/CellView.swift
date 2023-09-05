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

import SwiftUI

struct CellView: View {
    var dimesnion: CGFloat
    var inputArray : [Int] = []
    var callback : () -> Bool
    var body: some View {
        ZStack{
            Rectangle()
                .stroke(Color.black.opacity(0.3))
                .frame(width: dimesnion,height: dimesnion)
            VStack(spacing: 0) {
                ForEach(0..<3){ row in
                    HStack(spacing: 0) {
                        ForEach(0..<3){ col in
                            Rectangle()
                                .stroke(Color.clear)
                                .frame(width: dimesnion/3, height: dimesnion/3)
                                .overlay {
                                    let current = col+1 + (row*3)
                                    if callback(){
                                        Text(inputArray.contains(current) ? "\(current)" : "")
                                            .foregroundColor(Color("prefilledText"))
                                            .font(.caption)
                                            .bold()
                                    }
                                    
                                }
                        }
                    }
                }
            }
                
        }
        
        
    }
    
}

struct CellView_Previews: PreviewProvider {
    
    static var previews: some View {
        CellView(dimesnion: 50, inputArray: [1,2,3], callback: {return true})
    }
}
