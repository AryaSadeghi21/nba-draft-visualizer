import SwiftUI

struct DraftSettingsView: View {
    @Binding var activeTab: Tab   // 👈 Add this
    @State private var draftType = "Snake"
    @State private var numPlayers = ""
    @State private var draftPosition = ""
    
    var body: some View {
        VStack {
            // Top bar
            HStack {
                Button(action: {
                    activeTab = .home   // 👈 custom back action
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(AppColors.textPrimary)
                        .frame(width: 24, height: 24)
                }
                Spacer()
                Text("Draft Settings")
                    .font(AppFonts.heading(size: 18))
                    .foregroundColor(AppColors.textPrimary)
                Spacer().frame(width: 24) // balances back button
            }
            .padding()
            .background(AppColors.background)
            
            ScrollView {
                // Draft Type
                SectionHeader(title: "Draft Type")
                
                VStack(spacing: 12) {
                    DraftOption(title: "Snake Draft",
                                subtitle: "Players are selected in a back-and-forth order.",
                                selected: draftType == "Snake") {
                        draftType = "Snake"
                    }
                    DraftOption(title: "Auction Draft",
                                subtitle: "Teams bid on players with a set budget.",
                                selected: draftType == "Auction") {
                        draftType = "Auction"
                    }
                }
                .padding(.horizontal)
                
                // Amount of Players
                SectionHeader(title: "Amount of Players")
                HStack {
                    Text("Players:")
                        .font(AppFonts.body(size: 14))
                        .foregroundColor(AppColors.textPrimary)
                    Spacer()
                    TextField("e.g. 10", text: $numPlayers)
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                        .padding(8)
                        .background(AppColors.secondaryBackground)
                        .cornerRadius(6)
                        .foregroundColor(AppColors.textPrimary)
                }
                .padding(.horizontal)

                // Draft Position
                SectionHeader(title: "Your Place in Draft")
                HStack {
                    Text("Position:")
                        .font(AppFonts.body(size: 14))
                        .foregroundColor(AppColors.textPrimary)
                    Spacer()
                    TextField("e.g. 1", text: $draftPosition)
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                        .padding(8)
                        .background(AppColors.secondaryBackground)
                        .cornerRadius(6)
                        .foregroundColor(AppColors.textPrimary)
                }
                .padding(.horizontal)
                
                // Save button
                Button(action: {
                    // Save settings action
                }) {
                    Text("Save Settings")
                        .font(AppFonts.heading(size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColors.accent)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
            
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                to: nil, from: nil, for: nil)
            }
            
            
        }
        .background(AppColors.background.ignoresSafeArea())
    }
}

struct SectionHeader: View {
    let title: String
    var body: some View {
        Text(title)
            .font(AppFonts.heading(size: 22))
            .foregroundColor(AppColors.textPrimary)
            .padding(.top, 24)
            .padding(.horizontal)
    }
}

struct DraftOption: View {
    let title: String
    let subtitle: String
    let selected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(AppFonts.body(size: 14))
                        .foregroundColor(AppColors.textPrimary)
                    Text(subtitle)
                        .font(AppFonts.body(size: 12))
                        .foregroundColor(AppColors.textSecondary)
                }
                Spacer()
                if selected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                } else {
                    Circle()
                        .stroke(AppColors.border, lineWidth: 2)
                        .frame(width: 20, height: 20)
                }
            }
            .padding()
            .background(AppColors.secondaryBackground)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(AppColors.border, lineWidth: 1)
            )
        }
    }
}
