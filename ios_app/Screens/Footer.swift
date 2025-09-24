import SwiftUI

struct Footer: View {
    @Binding var activeTab: Tab
    
    var body: some View {
        HStack {
            FooterItem(
                icon: "house.fill",
                label: "Home",
                active: activeTab == .home
            ) {
                activeTab = .home
            }
            FooterItem(
                icon: "doc",
                label: "Draft",
                active: activeTab == .draft
            ) {
                activeTab = .draft
            }
        }
        .padding(.vertical, 8)
        .background(AppColors.secondaryBackground)
    }
}

struct FooterItem: View {
    let icon: String
    let label: String
    let active: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .foregroundColor(active ? AppColors.textPrimary : AppColors.textSecondary)
                    .frame(height: 24)
                Text(label)
                    .font(AppFonts.body(size: 12))
                    .foregroundColor(active ? AppColors.textPrimary : AppColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
        }
    }
}
