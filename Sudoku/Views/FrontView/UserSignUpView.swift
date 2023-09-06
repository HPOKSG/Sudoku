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

struct UserSignUpView: View {
    @EnvironmentObject var soundStorage: SoundDataStorage // Access UserHistory
    @EnvironmentObject var userDetailStorageObject: UserHistory // Access UserHistory from the environment
    @EnvironmentObject var storageObject: StorageObject // Access StorageObject from the environment
    @State var isPresentingError: Bool = false // State to control error presentation
    @State var isPresentingErrorEmpty: Bool = false // State to control empty error presentation
    @Binding var presentingSignUp: Bool // Binding to control presentation
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3) // Semi-transparent black background
                .edgesIgnoringSafeArea(.all) // Ignore safe area edges
            
            VStack(alignment: .leading, spacing: 25) {
                Text(soundStorage.language ? "New User" : "Người Chơi Mới") // Title: "New User"
                    .font(.title2) // Set font size
                    .bold() // Apply bold font style
                
                TextField(soundStorage.language ? "Please Enter Name..." : "Xin Mời Nhập Tên...", text: $userDetailStorageObject.currentUser) // Text field for user's name
                    .background() // Apply background
                
                Button {
                    if userDetailStorageObject.currentUser.isEmpty {
                        withAnimation {
                            isPresentingErrorEmpty = true // Show empty error message
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation {
                                isPresentingErrorEmpty = false // Hide empty error message after a delay
                            }
                        }
                    } else {
                        if userDetailStorageObject.doesUserExist() {
                            withAnimation {
                                isPresentingError = true // Show user already exists error message
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation {
                                    isPresentingError = false // Hide error message after a delay
                                }
                            }
                        } else {
                            userDetailStorageObject.insertNewUser() // Insert a new user
                            presentingSignUp.toggle() // Toggle the presentation state
                        }
                    }
                } label: {
                    HStack(alignment: .center) {
                        Spacer()
                        Text(soundStorage.language ? "Submit" : "Đăng Kí") // Submit button label
                            .foregroundColor(Color(storageObject.theme ? .black : .white)) // Set text color based on theme
                            .bold() // Apply bold font style
                            .padding(.all) // Add padding
                            .frame(width: 120, height: 40) // Set button dimensions
                            .background() {
                                Capsule() // Apply capsule shape to the button
                            }
                        Spacer()
                    }
                }
                
                Text(soundStorage.language ? "Old User: Please Select Your Name" : "Đã Đăng Kí: Hãy Chọn Tài Khoản") // Instructions for old users
                    .font(.title3) // Set font size
                    .bold() // Apply bold font style
                
                ScrollView(showsIndicators: true) {
                    VStack(spacing: 20) {
                        ForEach(userDetailStorageObject.userDetail, id: \.id) { user in
                            Button {
                                userDetailStorageObject.currentUser = user.name // Set the current user's name
                                presentingSignUp.toggle() // Toggle the presentation state
                            } label: {
                                RoundedRectangle(cornerRadius: 15) // Rounded rectangle button
                                    .fill(Color.gray.opacity(0.6))
                                    .frame(height: 43) // Set button height
                                    .overlay {
                                        Text(user.name.capitalized) // Display the user's name
                                            .foregroundColor(Color(storageObject.theme ? .black : .white)) // Set text color based on theme
                                            .bold() // Apply bold font style
                                    }
                                   
                            }
                        }
                    }
                }
            }
            .padding(.all) // Add overall padding
            .background {
                RoundedRectangle(cornerRadius: 15) // Rounded rectangle background
                    .fill(Color("gameOverBackground")) // Fill color
            }
            .frame(width: 360, height: 485) // Set the frame dimensions
            
            ErrorView(errorMessage: "User Name Already Exist") // Error view for existing user
                .position(x: UIScreen.main.bounds.width/2, y: isPresentingError ? 100 : -30) // Position error view
                .edgesIgnoringSafeArea(.top) // Ignore safe area edges
            
            ErrorView(errorMessage: "User Name Cant Be Empty") // Error view for empty user name
                .position(x: UIScreen.main.bounds.width/2, y: isPresentingErrorEmpty ? 100 : -30) // Position error view
                .edgesIgnoringSafeArea(.top) // Ignore safe area edges
        }
    }
}


struct UserSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        UserSignUpView(presentingSignUp: .constant(true))
            .environmentObject(UserHistory())
            .environmentObject(SoundDataStorage())
            .environmentObject(StorageObject())
    }
}
