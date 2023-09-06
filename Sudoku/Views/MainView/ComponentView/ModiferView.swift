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

struct ModiferView: View {
    @EnvironmentObject var storageObject: StorageObject
    @Binding var noteStatus: NoteStatus
    @Binding var currX: Int
    @Binding var currY: Int
    
    var body: some View {
        HStack(spacing: UIScreen.main.bounds.width / 4) {
            
            // Button to erase content
            Button {
                if noteStatus == .on {
                    // If in note mode, pop last item from storage
                    if let _ = storageObject.noteStorageArray[currX][currY].popLast() {
                        // Handle erasing a note
                    } else {
                        // Handle when there's nothing to erase
                    }
                } else {
                    // If not in note mode, clear cell content
                    if currX != -1 && currY != -1 {
                        storageObject.currArray[currX][currY] = -1
                        storageObject.errorTextMap[currX][currY] = false
                        storageObject.fillCell(x: currX, y: currY)
                    }
                }
            } label: {
                ModiferItemView(title: "Erase", imgName: "eraser.line.dashed")
            }
        
            // Button to toggle notes mode
            Button {
                noteStatus = noteStatus == .off ? .on : .off
            } label: {
                ModiferItemView(title: "Notes", imgName: "pencil.tip.crop.circle.badge.plus")
                    .overlay {
                        RoundedRectangle(cornerRadius: 20.0)
                            .fill(Color(hex: noteStatus == .on ? 0x3359AF : 0x6F7785))
                            .frame(width: 50, height: 30)
                            .overlay {
                                Text(noteStatus == .on ? "ON" : "OFF")
                                    .foregroundColor(Color.white)
                                    .bold()
                            }
                            .padding(.bottom, 50)
                            .padding(.leading, 50)
                    }
            }
        }
    }
}

struct ModiferView_Previews: PreviewProvider {
    static var previews: some View {
        ModiferView(noteStatus: .constant(.off),currX: .constant(-1),currY: .constant(-1))
            .environmentObject(StorageObject())
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255.0
        let green = Double((hex >> 8) & 0xff) / 255.0
        let blue = Double(hex & 0xff) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

struct ModiferItemView: View {
    var title: String
    var imgName: String
    var body: some View {
        VStack{
            Image(systemName: "\(imgName)")
                .font(.system(size: 30))
            Text("\(title)")
                .bold()
        }
        .foregroundColor(Color(hex: 0x6F7785))
    }
}
