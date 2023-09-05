//
//  TopUserView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 05/09/2023.
//

import SwiftUI

struct TopUserView: View {
    @EnvironmentObject var userHistoryStorage : UserHistory
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading){
                ScrollView(showsIndicators: true){
                    VStack(spacing: 25) {
                        ForEach(0..<userHistoryStorage.sortedObjects.count) {index in
                            UserItemView(user: userHistoryStorage.sortedObjects[index]){
                                return index + 1
                            }
                              
                        }
                    }
                }
            }
            .navigationTitle("Top User")
        }
        
    }
}

struct TopUserView_Previews: PreviewProvider {
    static var previews: some View {
        TopUserView()
            .environmentObject(UserHistory())
    }
}
