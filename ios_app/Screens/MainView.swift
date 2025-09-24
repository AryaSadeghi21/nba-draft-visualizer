import SwiftUI

struct MainView: View {
    @StateObject var settings = DraftSettings()
    @State private var activeTab: Tab = .home
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch activeTab {
                case .home:
                    ContentView(activeTab: $activeTab).environmentObject(settings)
                case .draft:
                    DraftSettingsView(activeTab: $activeTab).environmentObject(settings)
                }
            }
            
            Footer(activeTab: $activeTab)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColors.background)
    }
}

#Preview {
    MainView()
}
