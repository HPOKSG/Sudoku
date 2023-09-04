//
//  CellView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 23/08/2023.
//

import SwiftUI

struct CellView: View {
    var dimesnion: CGFloat
    var inputArray : [Int] = []
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
                                    Text(inputArray.contains(current) ? "\(current)" : "")
                                        .foregroundColor(Color.black.opacity(0.5))
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

struct CellView_Previews: PreviewProvider {
    
    static var previews: some View {
        CellView(dimesnion: 50, inputArray: [1,2,3])
    }
}
