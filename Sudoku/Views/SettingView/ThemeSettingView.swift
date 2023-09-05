//
//  ThemeSettingView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 05/09/2023.
//

import SwiftUI

struct ThemeSettingView: View {
    @EnvironmentObject var storageObject : StorageObject
    var body: some View {
        HStack(spacing: 20){
            Button{
                storageObject.theme = true
            }label: {
                Circle()
                    .fill(Color.white)
                     .frame(width: 50)
                     .overlay{
                         Circle()
                             .stroke(storageObject.theme == true ? Color("darkBlue") : Color.clear,lineWidth: 2)
                     }
            }
            Button{
                storageObject.theme = false
            }label: {
                Circle()
                    .fill(Color.black)
                     .frame(width: 50)
                     .overlay{
                         Circle()
                             .stroke(storageObject.theme == false ? Color("darkBlue") : Color.clear,lineWidth: 2)
                     }
            }
        }
        .padding(.all)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("gameOverBackground"))
        }
        .preferredColorScheme(storageObject.theme == true ? .light : .dark)
        
    }
}

struct ThemeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSettingView()
            .environmentObject(StorageObject())
    }
}
