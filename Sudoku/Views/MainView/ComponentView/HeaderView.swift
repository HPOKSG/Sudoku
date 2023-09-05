//
//  HeaderView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 24/08/2023.
//

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
