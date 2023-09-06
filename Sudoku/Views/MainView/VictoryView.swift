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

struct VictoryView: View {
    // MARK: - Properties
    
    // Environment property to manage presentation mode
    @Environment(\.presentationMode) var presentationMode
    
    // Environment objects for shared data
    @EnvironmentObject var storageObject: StorageObject
    @EnvironmentObject var soundStorage: SoundDataStorage
    @EnvironmentObject var userDetailStorage: UserHistory
    
    // State property to control presentation of a new game
    @State var isPresentingNewGame: Bool = false
    @State var isPresentingBadge: Bool = false

    // MARK: - Body
    var body: some View {
        ZStack {
            // Background color ignoring safe area
            Color("victoryBackground")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Title label for level completion
                Text("Level Completed!")
                    .bold()
                    .font(.system(size: 42))
                    .foregroundColor(.white)
                
                VStack {
                    // Display difficulty level
                    StatisticItemView(imageName: "ranking", title: "Difficulty", description: storageObject.mode.rawValue.capitalized)
                    
                    // Divider line
                    Divider()
                        .background(.white)
                        .padding(.horizontal, 40)
                    
                    // Display score
                    StatisticItemView(imageName: "scoreIcon", title: "Score", description: "\(StorageObject.currPoint)")
                    
                    // Divider line
                    Divider()
                        .background(.white)
                        .padding(.horizontal, 40)
                    
                    // Display time
                    StatisticItemView(imageName: "timerIcon", title: "Time", description: storageObject.convertToTimer())
                }
                .padding(.horizontal)
                .overlay {
                    // Overlay to style the statistics container
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.1))
                        .padding(.horizontal)
                }
                
                // Button to return to the main view
                Button {
                    soundStorage.playSound(sound: SongTheme.theme.rawValue)
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Color.clear
                        .frame(width: 320, height: 70)
                        .clipShape(Capsule())
                        .shadow(radius: 10, y: 3)
                        .overlay {
                            Text("Main View")
                                .foregroundColor(Color.white)
                                .bold()
                                .font(.title2)
                        }
                }
            }
            if userDetailStorage.newBadageAdded.count > 0{
                BadgeView(badge: BadgeImage.getBadgeView(userDetailStorage.newBadageAdded.trimmingCharacters(in: CharacterSet(charactersIn: ","))))
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            userDetailStorage.newBadageAdded = ""
                        }
                }
            }
        }
    }
}


struct VictoryView_Previews: PreviewProvider {
    static var previews: some View {
        VictoryView()
            .environmentObject(StorageObject())
            .environmentObject(SoundDataStorage())
            .environmentObject(UserHistory())
    }
}

struct StatisticItemView: View {
    var imageName : String
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            HStack{
                Image(imageName)
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 50,height: 50)
                    .scaleEffect(0.23)
                Text(title)
                    .foregroundColor(.white)
                    .bold()
                Spacer()
                Text(description)
                    .foregroundColor(.white)
                    .bold()
            }
            .padding(.horizontal)
           
        }
    }
}
