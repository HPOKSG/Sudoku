import SwiftUI
import AVFAudio
struct ContentView: View {
    @EnvironmentObject var storageObject: StorageObject
    @EnvironmentObject var soundStorage: SoundDataStorage
    @EnvironmentObject var userDetailStorage: UserHistory
    var body: some View {
        VStack{
            Button("clickme") {
                userDetailStorage.updateUserDetail(mode: .easy, point: 200, time: 200)
                print(userDetailStorage.userDetail)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(StorageObject())
            .environmentObject(SoundDataStorage())
            .environmentObject(UserHistory())
    }
}


