import SwiftUI

struct MainView: View {
    @State private var activeTab: Tab = .home
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch activeTab {
                case .home:
                    ContentView(activeTab: $activeTab)
                case .draft:
                    DraftSettingsView(activeTab: $activeTab) 
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
