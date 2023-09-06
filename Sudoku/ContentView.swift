import SwiftUI
import AVFAudio
struct ContentView: View {
    var body: some View {
        VStack{
            Button("clickme") {
                AudioServicesPlaySystemSound(1008);
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


