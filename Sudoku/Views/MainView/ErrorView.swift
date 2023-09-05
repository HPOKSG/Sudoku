//
//  ErrorView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 25/08/2023.
//

import SwiftUI

struct ErrorView: View {
    var errorMessage: String
    var body: some View {
        
        VStack {
            Text(errorMessage)
                .bold()
                .foregroundColor(Color.white)
                .padding(.all)
                .padding(.horizontal)
                .background(Color("darkBlue"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: "hjhj")
    }
}
