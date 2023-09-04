//
//  GridView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 23/08/2023.
//

import SwiftUI

struct GridView: View {
    @EnvironmentObject var storageObject: StorageObject
    @Binding var dimension: Double
    @State var noteStatus: NoteStatus = .on
    @State var curretnValue = 9
    @Binding var currX: Int
    @Binding var currY: Int
    var body: some View {
        ZStack {
            BorderView(dimension: dimension)
            VStack(spacing: 0) {
                ForEach(0..<3){ outerRow in
                    HStack(spacing: 0) {
                        ForEach(0..<3){ outerCol in
                            ZStack {
                                HighLightView(dimension: dimension/9, outerRow: outerRow, outerCol: outerCol, callback: getRightColor(x:y:))
                                Rectangle()
                                    .stroke(Color.black,lineWidth: 3)
                                    .frame(width: dimension/3, height: dimension/3)
                                    .overlay {
                                        SquareView(dimension: dimension, outerRow: outerRow, outerCol: outerCol, currX: $currX,currY: $currY)
                                    }
                            }
                        }
                    }
                }
            }            
        }
        
    }
    
    func getRightColor(x: Int, y: Int) -> Color{
        if storageObject.shadedMap[x][y] == "" {return Color.clear}
        return Color(storageObject.shadedMap[x][y])
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(dimension: .constant(360), currX: .constant(-1), currY: .constant(-1))
            .environmentObject(StorageObject())
    }
}

struct BorderView: View {
    var dimension: CGFloat
    var body: some View {
        Rectangle()
            .stroke(Color.black,lineWidth: 3)
            .frame(width: dimension, height: dimension)
    }
}

struct HighLightView: View {
    var dimension: CGFloat
    var outerRow: Int
    var outerCol: Int
    
    var callback: (Int, Int) -> Color
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3){ innerRow in
                HStack(spacing: 0) {
                    ForEach(0..<3){ innerCol in
                        let xCoor = (outerRow*3) + innerRow
                        let yCoor  = (outerCol*3) + innerCol
                        Rectangle()
                            .stroke(Color.clear)
                            .frame(width: dimension, height: dimension)
                            .background(callback(xCoor, yCoor))
                    }
                }
            }
        }
    }
}



    struct SquareView: View {
        @EnvironmentObject var storageObject : StorageObject
        var dimension: CGFloat
        var outerRow: Int
        var outerCol: Int
        @Binding var currX: Int
        @Binding var currY: Int
        var body: some View {
            VStack(spacing: 0) {
               
                ForEach(0..<3){ innerRow in
                    HStack(spacing: 0) {
                        ForEach(0..<3){ innerCol in
                            let xCoor = (outerRow*3) + innerRow
                            let yCoor  = (outerCol*3) + innerCol
                            GeometryReader{ geometry in
                                Button {
                                    currX = xCoor
                                    currY = yCoor
                                    storageObject.fillCell(x: xCoor, y: yCoor)
                                } label: {
                                    CellView(dimesnion: dimension/9, inputArray: storageObject.noteStorageArray[xCoor][yCoor])
                                        .overlay {
                                            let preFilledVal = storageObject.preFilledArray[xCoor][yCoor]
                                            let playVal = storageObject.currArray[xCoor][yCoor]
                                            if  preFilledVal != -1{
                                                Text("\(preFilledVal)")
                                                    .font(.largeTitle)
                                                    .foregroundColor(.black)
                                            }else{
                                                Text(playVal == -1 ? "" :  "\(playVal)")
                                                    .font(.largeTitle)
                                                    .foregroundColor(storageObject.errorTextMap[xCoor][yCoor] ? Color("errorText") : Color("darkBlue"))
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
