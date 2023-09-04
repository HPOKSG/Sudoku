//
//  HeaderView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 24/08/2023.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var storageObject: StorageObject
    @Binding var isPlaying: Bool
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
                }
                .foregroundColor(Color(hex: 0x6F7785))
                
                Button {
                    isPlaying.toggle()
                    if (isPlaying == true){
                        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    }else{
                        timer.upstream.connect().cancel()
                    }
                } label: {
                    Image(systemName: isPlaying ?   "pause.circle.fill": "play.circle.fill" )
                        .foregroundColor(Color(hex: 0x6F7785).opacity(0.6))
                        .font(.title)
                }

            }
        }
        .onChange(of: isPlaying, perform: { newValue in
            if (isPlaying == true){
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
        HeaderView(isPlaying: .constant(true))
            .environmentObject(StorageObject())
    }
}
