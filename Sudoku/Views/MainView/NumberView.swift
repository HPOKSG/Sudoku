//
//  NumberView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 24/08/2023.
//

import SwiftUI

struct NumberView: View {
    @EnvironmentObject var storageObject: StorageObject
    @Binding var noteState: NoteStatus
    @Binding var currX: Int
    @Binding var currY: Int
    @Binding var errorCoordinate: Int
    
    var body: some View {
        HStack(spacing:15){
            ForEach(1..<10) { num in
                Button {
                    if noteState == .off{
                        if currX != -1 && currY != -1{
                            if storageObject.preFilledArray[currX][currY] == -1{
                                storageObject.currArray[currX][currY] = num
                            }else{
                                errorCoordinate = (currX + 1) * 9 + currY + 1
                            }
                        }
                    }else{
                        if currX != -1 && currY != -1{
                            storageObject.insertNumToNoteArray(x: currX, y: currY, num: num)
                        }
                    }
                } label: {
                    Text("\(num)")
                        .foregroundColor(noteState == .on ? Color("gray") : Color("numColor"))
                        .font(.system(size:42))
                }

            }
        }
    }
}

struct NumberView_Previews: PreviewProvider {
    static var previews: some View {
        NumberView(noteState: .constant(.on), currX: .constant(0), currY: .constant(0), errorCoordinate: .constant(19))
    }
}