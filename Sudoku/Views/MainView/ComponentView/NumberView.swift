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

struct NumberView: View {
    @EnvironmentObject var storageObject: StorageObject
    @Binding var noteState: NoteStatus
    @Binding var currX: Int
    @Binding var currY: Int
    @Binding var errorPopUP: Bool
    var body: some View {
        HStack(spacing:15){
            ForEach(1..<10) { num in
                Button {
                    if noteState == .off{
                        if currX != -1 && currY != -1{
                            //check if enter number in empty field
                            if storageObject.preFilledArray[currX][currY] == -1{
                                if (num != storageObject.currArray[currX][currY]){
                                    storageObject.errorTextMap[currX][currY] = false
                                    
                                    storageObject.currArray[currX][currY] = num
                                    
                                    //reset the color fill cell
                                    storageObject.fillCell(x: currX, y: currY)
                                    
                                    if (!storageObject.isValidMove()){
                                        StorageObject.currMistake += 1
                                        StorageObject.currPoint -= storageObject.pointIncrement
                                        storageObject.isLoosing()
                                        storageObject.highlightErorCell(x: currX, y: currY)
                                        vibrate()
                                    }else{
                                        storageObject.isWinning()
                                        if storageObject.isNewValidMove(x: currX, y: currY){
                                            StorageObject.currPoint += storageObject.pointIncrement
                                        }
                                    }
                                }else{
                                    storageObject.currArray[currX][currY] = -1
                                }
                                //reset errorText at coordinate before check again if
                                //it is valid move or not
                                
                            }else{
                                withAnimation(){
                                    vibrate()
                                    errorPopUP = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation {
                                        errorPopUP = false
                                    }
                                }
                            }
                        }
                    }else{
                        if currX != -1 && currY != -1{
                            storageObject.insertNumToNoteArray(x: currX, y: currY, num: num)
                        }
                    }
                } label: {
                    if noteState == .on{
                        if storageObject.countCurrentNum(num: num){
                            Text(" ")
                                .disabled( storageObject.countCurrentNum(num: num))
                        }else{
                            Text("\(num)")
                                .foregroundColor(noteState == .on ? Color("gray") : Color("numColor"))
                                .font(.system(size:42))
                        }
                    }else{
                        Text("\(num)")
                            .foregroundColor(noteState == .on ? Color("gray") : Color("numColor"))
                            .font(.system(size:42))
                    }
                   
                }
                
            }
        }
    }
}

struct NumberView_Previews: PreviewProvider {
    static var previews: some View {
        NumberView(noteState: .constant(.on), currX: .constant(0), currY: .constant(0), errorPopUP: .constant(false))
            .environmentObject(StorageObject())
    }
}
