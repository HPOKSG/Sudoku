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

struct HeaderView: View {
    @EnvironmentObject var storageObject: StorageObject
    @EnvironmentObject var soundStorage : SoundDataStorage
    @State private var timer  = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        HStack{
            VStack (alignment: .leading){
                // Display difficulty level
                Text(soundStorage.language ?  "Difficulty" : "Mức độ")
                Text(soundStorage.language ? storageObject.mode.rawValue.capitalized : storageObject.mode.vietnamese)
                    .bold()
            }
            .foregroundColor(Color(hex: 0x6F7785))
            Spacer()
            VStack (){
                // Display mistake count
                Text(soundStorage.language ?  "Mistake" : "Lỗi")
                Text("\(StorageObject.currMistake)/\(storageObject.maxAttemp)")
                    .bold()
            }
            .foregroundColor(Color(hex: 0x6F7785))
            Spacer()
            VStack (){
                // Display current score
                Text(soundStorage.language ? "Score" : "Điểm")
                Text("\(StorageObject.currPoint)")
                    .bold()
            }
            .foregroundColor(Color(hex: 0x6F7785))
            Spacer()
            HStack {
                VStack (){
                    // Display elapsed time
                    Text(soundStorage.language ? "Time" : "Thời gian")
                    Text(storageObject.convertToTimer())
                        .bold()
                        .onReceive(timer){ firedDate in
                            storageObject.secondsElapsed += 1
                        }
                        
                       
                }
                .frame(width: 80)
                .foregroundColor(Color(hex: 0x6F7785))

                Button {
                    // Toggle game status between playing and paused
                    storageObject.gameStatus = storageObject.gameStatus == .isPlaying ? .pause : .isPlaying
                } label: {
                    Image(systemName: storageObject.gameStatus == .isPlaying ?   "pause.circle.fill": "play.circle.fill" )
                        .foregroundColor(Color(hex: 0x6F7785).opacity(0.6))
                        .font(.title)
                }

            }
        }
        .onChange(of: StorageObject.gameStatusStorage, perform: { newValue in
            if (storageObject.gameStatus == .isPlaying){
                // Start the timer when the game is playing
                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }else{
                // Cancel the timer when the game is paused
                timer.upstream.connect().cancel()
            }
        })
        .padding(.all)
       
    }
}


struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .environmentObject(StorageObject())
            .environmentObject(SoundDataStorage())
    }
}
