import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            VStack {
                // Custom Tab Bar
                HStack {
                    Spacer()
                    TabBarButton(title: "Easy", isSelected: selectedTab == 0) {
                        selectedTab = 0
                    }
                    Spacer()
                    TabBarButton(title: "Medium", isSelected: selectedTab == 1) {
                        selectedTab = 1
                    }
                    Spacer()
                    TabBarButton(title: "Hard", isSelected: selectedTab == 2) {
                        selectedTab = 2
                    }
                    Spacer()
                }
                .padding()
                .background(Color.white)
                
                // Content for each tab
                TabView(selection: $selectedTab) {
                    Text("Tab 1 Content")
                        .tag(0)
                    Text("Tab 2 Content")
                        .tag(1)
                    Text("Tab 3 Content")
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }// Ensure content doesn't overlap status bar
            .navigationBarTitle("Statistic", displayMode: .inline) // Set navigation title
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabBarButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(isSelected ? .headline : .subheadline)
                .foregroundColor(isSelected ? .blue : .gray)
        }
    }
}
