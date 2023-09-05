//
//  UserSignUpView.swift
//  Sudoku
//
//  Created by Hữu Phước  on 05/09/2023.
//

import SwiftUI

struct UserSignUpView: View {
    @EnvironmentObject var userDetailStorageObject: UserHistory
    @EnvironmentObject var storageObject: StorageObject
    @State var isPresentingError : Bool = false
    @State var isPresentingErrorEmpty : Bool = false
    @Binding var presentingSignUp: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading,spacing: 25){
                Text("New User")
                    .font(.title2)
                    .bold()
                TextField("Please Enter Name...", text: $userDetailStorageObject.currentUser)
                    .background()
                Button {
                    if(userDetailStorageObject.currentUser.isEmpty){
                        withAnimation {
                            isPresentingErrorEmpty = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                isPresentingErrorEmpty = false
                            }
                        }
                    }else{
                        if(userDetailStorageObject.doesUserExist()){
                            withAnimation {
                                isPresentingError = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    isPresentingError = false
                                }
                            }
                        }else{
                            userDetailStorageObject.insertNewUser()
                            presentingSignUp.toggle()
                        }
                    }
                    
                } label: {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Submit")
                            .foregroundColor(Color(storageObject.theme ? .black : .white))
                            .bold()
                            .padding(.all)
                            .frame(width: 120, height: 40)
                            .background() {
                                Capsule()
                        }
                        Spacer()
                    }
                    
                }
                Text("Old User: Please Select Your Name")
                    .font(.title3)
                    .bold()
                ScrollView(showsIndicators: true) {
                    VStack(spacing: 20) {
                        ForEach(userDetailStorageObject.userDetail, id: \.id) { user in
                            Button{
                                userDetailStorageObject.currentUser = user.name
                                presentingSignUp.toggle()
                            }label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.gray.opacity(0.6))
                                    .frame(height: 40)
                                    .overlay{
                                        Text(user.name.capitalized)
                                            .foregroundColor(Color(storageObject.theme ? .black : .white))
                                            .bold()
                                        
                                    }
                            }
                        }
                    }
                }
            }
            .padding(.all)
            .padding(.all)
            .background{
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("gameOverBackground"))
            }
            .frame(width: 360, height: 485)
            ErrorView(errorMessage: "User Name Already Exist")
                .position(x: UIScreen.main.bounds.width/2, y: isPresentingError ? 100 : -30)
                .edgesIgnoringSafeArea(.top)
            ErrorView(errorMessage: "User Name Cant Be Empty")
                .position(x: UIScreen.main.bounds.width/2, y: isPresentingErrorEmpty ? 100 : -30)
                .edgesIgnoringSafeArea(.top)
        }
    }
}

struct UserSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpView(presentingSignUp: .constant(true))
            .environmentObject(UserHistory())
            .environmentObject(StorageObject())
    }
}
