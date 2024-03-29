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

// A view for setting the theme (light/dark mode) of the application.
struct ThemeSettingView: View {
    @EnvironmentObject var storageObject: StorageObject
    
    var body: some View {
        HStack(spacing: 20) {
            // Button to set the theme to light mode.
            Button {
                storageObject.theme = true
            } label: {
                Circle()
                    .fill(Color.white)
                    .frame(width: 50)
                    .overlay {
                        Circle()
                            .stroke(storageObject.theme == true ? Color("darkBlue") : Color.clear, lineWidth: 2)
                    }
            }
            
            // Button to set the theme to dark mode.
            Button {
                storageObject.theme = false
            } label: {
                Circle()
                    .fill(Color.black)
                    .frame(width: 50)
                    .overlay {
                        Circle()
                            .stroke(storageObject.theme == false ? Color("darkBlue") : Color.clear, lineWidth: 2)
                    }
            }
        }
        .padding(.all)
        .background {
            // Apply a background color and a curvy triangle shape.
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("gameOverBackground"))
                .background {
                    // Create a curvy downward triangle shape.
                    CurvyDownwardTriangle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("gameOverBackground"))
                        .offset(x: 50, y: -30)
                }
        }
        .preferredColorScheme(storageObject.theme == true ? .light : .dark)
    }
}

struct ThemeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the ThemeSettingView with an environment object for storage.
        ThemeSettingView()
            .environmentObject(StorageObject())
    }
}

// A custom shape for creating a curvy downward triangle.
struct CurvyDownwardTriangle: Shape {
    var angleCurvature: CGFloat = 0.40 // Adjust this value to control the curvature
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))

        let control1 = CGPoint(x: rect.minX + rect.width * angleCurvature, y: rect.minY)
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY), control: control1)

        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))

        let control2 = CGPoint(x: rect.maxX - rect.width * angleCurvature, y: rect.minY)
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.minY), control: control2)

        path.closeSubpath()
        return path
    }
}

