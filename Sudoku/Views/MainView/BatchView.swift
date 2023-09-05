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

struct BatchView: View {
    var badge : BadgeImage
    var body: some View {
        ZStack {
            HStack{
                Text(badge.name)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Image(badge.rawValue)
            }
            .padding(.all)
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.green.opacity(0.9))
        }
        }
    }
}

struct BatchView_Previews: PreviewProvider {
    static var previews: some View {
        BatchView(badge: BadgeImage.allHard)
    }
}
