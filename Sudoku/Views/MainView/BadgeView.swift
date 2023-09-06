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

struct BadgeView: View {
    // MARK: - Properties
    
    // The badge to display
    var badge: BadgeImage
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            HStack {
                // Display the badge name
                Text(badge.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                // Display the badge image
                Image(badge.rawValue)
            }
            .padding(.all)
            .background {
                // Background with rounded rectangle and green color
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.green.opacity(0.9))
            }
        }
    }
}


struct BatchView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeView(badge: BadgeImage.allHard)
    }
}
