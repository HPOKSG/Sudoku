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
    var errorMessage: String // Error message to display
    var body: some View {
        
        VStack {
            Text(errorMessage) // Display the error message
                .bold() // Apply bold font style
                .foregroundColor(Color.white) // Set text color to white
                .padding(.all) // Add padding
                .padding(.horizontal) // Add horizontal padding
                .background(Color("darkBlue")) // Set background color
                .clipShape(RoundedRectangle(cornerRadius: 10)) // Clip the view into a rounded rectangle
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: "hjhj") // Preview with a sample error message
    }
}

