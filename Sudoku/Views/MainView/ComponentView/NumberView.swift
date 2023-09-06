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
    @EnvironmentObject var storageObject: StorageObject // Access StorageObject from the environment
    @EnvironmentObject var userDetailStorage: UserHistory // Access StorageObject from the environment
    @EnvironmentObject var soundStorage: SoundDataStorage // Access StorageObject from the environment
    @Binding var noteState: NoteStatus // Binding to control note state
    @Binding var currX: Int // Binding to track current X coordinate
    @Binding var currY: Int // Binding to track current Y coordinate
    @Binding var errorPopUP: Bool // Binding to control error popup state
    
    var body: some View {
        HStack(spacing: 15) {
            ForEach(1..<10) { num in
                Button {
                    //if on play mode
                    if noteState == .off {
                        //check if insert will specify celli
                        if currX != -1 && currY != -1 {
                            // Check if entering a number in an empty field
                            if storageObject.preFilledArray[currX][currY] == -1 {
                                if num != storageObject.currArray[currX][currY] {
                                    storageObject.errorTextMap[currX][currY] = false
                                    storageObject.currArray[currX][currY] = num
                                    // Reset the color-filled cell
                                    storageObject.fillCell(x: currX, y: currY)
                                    
                                    if !storageObject.isValidMove(x: currX, y: currY) {
                                        //update the game setting
                                        StorageObject.currMistake += 1
                                        StorageObject.currPoint = (StorageObject.currPoint - storageObject.pointIncrement) < 0 ? 0 :  StorageObject.currPoint - storageObject.pointIncrement
                                        if storageObject.isLoosing(){
                                            soundStorage.pauseMusic(sound: SongTheme.theme.rawValue)
                                            soundStorage.playSound(sound: SongTheme.lossing.rawValue)
                                        }
                                        storageObject.highlightErorCell(x: currX, y: currY)
                                        soundStorage.playErrorMove()
                                        soundStorage.vibrate()
                                    } else {
                                        if storageObject.isWinning() {
                                            soundStorage.pauseMusic(sound: SongTheme.theme.rawValue)
                                            soundStorage.playSound(sound: SongTheme.winning.rawValue)
                                            userDetailStorage.updateUserDetail(mode: storageObject.mode, point: StorageObject.currPoint, time: StorageObject.currPoint)
                                        }
                                        if storageObject.isNewValidMove(x: currX, y: currY) {
                                            StorageObject.currPoint += storageObject.pointIncrement
                                            soundStorage.playValidMove()
                                        }
                                    }
                                } else {
                                    storageObject.currArray[currX][currY] = -1
                                }
                            }
                            else {
                                if currX != -1 && currY != -1 {
                                    withAnimation() {
                                        soundStorage.vibrate()
                                        errorPopUP = true
                                    }
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        withAnimation {
                                            errorPopUP = false
                                        }
                                    }
                                }
                            }
                            // Reset errorText at coordinate before checking again if it is a valid move or not
                        }
                    } else {
                        if currX != -1 && currY != -1 {
                            storageObject.insertNumToNoteArray(x: currX, y: currY, num: num)
                        }
                    }
                } label: {
                    Text("\(num)")
                        .foregroundColor(noteState == .on ? Color("gray") : Color("numColor"))
                        .font(.system(size: 42))
                }
            }
        }
    }
}


struct NumberView_Previews: PreviewProvider {
    static var previews: some View {
        NumberView(noteState: .constant(.on), currX: .constant(0), currY: .constant(0), errorPopUP: .constant(false))
            .environmentObject(StorageObject())
            .environmentObject(UserHistory())
            .environmentObject(SoundDataStorage())
    }
}
