import SwiftUI

struct ContentView: View {
    @Binding var activeTab: Tab
    
    var body: some View {
        NavigationStack {
            VStack {
                // Top bar
                HStack {
                    Spacer()
                    Text("Home")
                        .font(AppFonts.heading(size: 20))
                        .foregroundColor(AppColors.textPrimary)
                    Spacer()
                    
                }
                .padding()
                .background(AppColors.background)

                Spacer().frame(height: 16)

                // Title
                Text("Welcome to Draft")
                    .font(AppFonts.heading(size: 40))
                    .foregroundColor(AppColors.textPrimary)
                    .padding(.bottom, 8)

                // Subtitle
                Text("Start a new draft to begin building your dream team.")
                    .font(AppFonts.body(size: 16))
                    .foregroundColor(AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 24)

                // Button switches tab to Draft
                Button {
                    activeTab = .draft
                } label: {
                    Text("Start a New Draft")
                        .font(AppFonts.heading(size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColors.accent)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 16)

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColors.background)
        }
    }
}

#Preview {
    MainView()
}
