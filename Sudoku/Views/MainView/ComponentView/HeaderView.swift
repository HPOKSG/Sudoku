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
    @State private var timer  = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        HStack{
            VStack (alignment: .leading){
                Text("Difficulty")
                Text(storageObject.mode.rawValue.capitalized)
                    .bold()
            }
            .foregroundColor(Color(hex: 0x6F7785))
            Spacer()
            VStack (){
                Text("Mistake")
                Text("\(StorageObject.currMistake)/\(storageObject.maxAttemp)")
                    .bold()
            }
            .foregroundColor(Color(hex: 0x6F7785))
            Spacer()
            VStack (){
                Text("Score")
                Text("\(StorageObject.currPoint)")
                    .bold()
            }
            .foregroundColor(Color(hex: 0x6F7785))
            Spacer()
            HStack {
                VStack (){
                    Text("Time")
                    Text(storageObject.convertToTimer())
                        .bold()
                        .onReceive(timer){ firedDate in
                            storageObject.secondsElapsed += 1
                        }
                        .frame(width: 65)
                       
                }
                .foregroundColor(Color(hex: 0x6F7785))

                Button {
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
                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
            }else{
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
    }
}
