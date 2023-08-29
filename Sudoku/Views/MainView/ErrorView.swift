//
//  ErrorView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 25/08/2023.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        
        VStack {
            Text("Can't fill in a pre-filled cell")
                .bold()
                .foregroundColor(Color.white)
                .padding(.all)
                .padding(.horizontal)
                .background(Color("darkBlue"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay {
                    CurvyDownwardTriangle()
                                .frame(width: 40, height: 30)
                                .foregroundColor(Color("darkBlue"))
                                .rotationEffect(Angle(degrees: 180))
                                .offset(x:80, y: 25)
            }
        }
           
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
struct CurvyDownwardTriangle: Shape {
    var angleCurvature: CGFloat = 0.35 // Adjust this value to control the curvature
    
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
