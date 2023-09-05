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
