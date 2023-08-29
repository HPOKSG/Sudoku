//
//  HeaderView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 24/08/2023.
//

import SwiftUI

struct HeaderView: View {
    @Binding var isPlaying: Bool
    var body: some View {
        HStack{
            VStack (alignment: .leading){
                Text("Difficulty")
                Text("Easy")
                    .bold()
            }
            .foregroundColor(Color(hex: 0x6F7785))
            Spacer()
            VStack (){
                Text("Score")
                Text("0")
                    .bold()
            }
            .foregroundColor(Color(hex: 0x6F7785))
            Spacer()
            HStack {
                VStack (){
                    Text("Time")
                    Text("00:18")
                        .bold()
                }
                .foregroundColor(Color(hex: 0x6F7785))
                
                Button {
                    isPlaying.toggle()
                } label: {
                    Image(systemName: isPlaying ? "play.circle.fill" :  "pause.circle.fill")
                        .foregroundColor(Color(hex: 0x6F7785).opacity(0.6))
                        .font(.title)
                }

            }
        }
        .padding(.all)
       
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(isPlaying: .constant(true))
    }
}
