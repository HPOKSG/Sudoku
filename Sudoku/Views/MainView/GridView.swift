//
//  GridView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 23/08/2023.
//

import SwiftUI

struct GridView: View {
    @State private var dimension = 360.0
    @State private var shadedmap : [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    @State var noteStatus: NoteStatus = .on
    @State var curretnValue = 9
    
    @Binding var currX: Int
    @Binding var currY: Int
    @Binding var errorCoordinate: Int
    @State  private var errorPopUP: Bool = false
    @State private var errorPosition = CGPoint(x: 0, y: 0)
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
                                        SquareView(dimension: dimension, outerRow: outerRow, outerCol: outerCol, shadedMap: $shadedmap,currX: $currX,currY: $currY, errorCoordinate: $errorCoordinate, errorPosition: $errorPosition)
                                        
                                        
                                        
                                    }
                            }
                        }
                    }
                }
            }
        }
        .onAppear{
            getSize()
        }
    }
    
    func getSize(){
        if UIDevice.current.userInterfaceIdiom == .phone {
            dimension = ((UIScreen.main.bounds.size.width-10)/9)*9
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            dimension = UIScreen.main.bounds.size.width * 0.8
        }
    }
    func getRightColor(x: Int, y: Int) -> Color{
        if shadedmap[x][y] == 0 {
            return Color.clear
        }else  if shadedmap[x][y] == 1 {
            return Color("shaded")
        }else{
            return Color("highlight")
        }
        
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(currX: .constant(-1), currY: .constant(-1), errorCoordinate: .constant(-1))
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
    @Binding var shadedMap: [[Int]]
    @Binding var currX: Int
    @Binding var currY: Int
    @Binding var errorCoordinate: Int
    
    
    @Binding var errorPosition : CGPoint
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3){ innerRow in
                HStack(spacing: 0) {
                    ForEach(0..<3){ innerCol in
                        let xCoor = (outerRow*3) + innerRow
                        let yCoor  = (outerCol*3) + innerCol
                        GeometryReader{ geometry in
                        Button {
                            errorPosition = geometry.frame(in: .global).origin
                            currX = xCoor
                            currY = yCoor
                            fillCell(x: xCoor, y: yCoor)
                        } label: {
                            
                                CellView(dimesnion: dimension/9, inputArray: storageObject.noteStorageArray[xCoor][yCoor])
                                    .overlay {
//
                                        let preFilledVal = storageObject.preFilledArray[xCoor][yCoor]
                                        let playVal = storageObject.currArray[xCoor][yCoor]
                                        if  preFilledVal != -1{
                                            Text("\(preFilledVal)")
                                                .font(.largeTitle)
                                                .foregroundColor(.black)
                                        }else{
                                            Text(playVal == -1 ? "" :  "\(playVal)")
                                                .font(.largeTitle)
                                                .foregroundColor(Color("darkBlue"))
                                        }
                                    }
                                
                            }
                            
                        }
                    }
                }
            }
        }
    }
    func fillCell(x: Int, y: Int){
        shadedMap = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        for index in 0..<9{
            shadedMap[x][index] = 1
        }
        for index in 0..<9{
            shadedMap[index][y] = 1
        }
        let subgridStartX = (x / 3) * 3
        let subgridStartY = (y / 3) * 3
        
        for row in subgridStartX..<subgridStartX + 3 {
            for col in subgridStartY..<subgridStartY + 3 {
                shadedMap[row][col] = 1
            }
        }
        
        shadedMap[x][y] = 2
    }
}
