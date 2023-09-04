//
//  ContentView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 22/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresentingNewGame: Bool = true

    var body: some View {
        ZStack {
            // Your main content goes here

            // Background view with a tap gesture recognizer
            Color.black.opacity(0.3) // Semi-transparent background
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        isPresentingNewGame.toggle() // Toggle the state
                    }
                }

            // Pop-up view
            
        }
    }
}

//struct GameSelectionView: View {
//    @Binding var isPresented: Bool
//
//    var body: some View {
//        // Your pop-up view content goes here
//
//        // Close button or action
//        Button("Close") {
//            withAnimation {
//                isPresented.toggle() // Toggle the state to close the pop-up
//            }
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
