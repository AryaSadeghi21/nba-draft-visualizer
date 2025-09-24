// DraftView.swift
import SwiftUI

struct DraftView: View {
    @EnvironmentObject var settings: DraftSettings
    @StateObject private var draftState = DraftState(players: [])
    @State private var searchText: String = ""
        
    private struct IndexedTeam: Identifiable {
        let id: Int      // index
        let name: String
    }
    
    private var indexedTeams: [IndexedTeam] {
        settings.teams.enumerated().map { .init(id: $0.offset, name: $0.element) }
    }

    
    init() {
        let players = loadPlayers()
        _draftState = StateObject(wrappedValue: DraftState(players: players))
    }
    
    // MARK: - Derived data
    var filteredPlayers: [Player] {
        guard !searchText.isEmpty else { return draftState.availablePlayers }
        let query = searchText.lowercased()
        return draftState.availablePlayers.filter { player in
            player.name.lowercased().contains(query)
        }
    }
    
    var topSuggestions: [Player] {
        let sorted = filteredPlayers.sorted { $0.projectedPoints > $1.projectedPoints }
        return Array(sorted.prefix(5))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            topBar
            teamsRow
            searchBar
            suggestionsList
            Spacer()
            footer
        }
        .background(AppColors.background.ignoresSafeArea())
    }
}

// MARK: - Subviews
private extension DraftView {
    var topBar: some View {
        HStack {
            Text("Round \(draftState.currentRound)")
                .font(AppFonts.heading(size: 20))
                .foregroundColor(AppColors.textPrimary)
            Spacer()
            Text("You are Team \(settings.draftPosition)")
                .font(AppFonts.body(size: 16))
                .foregroundColor(AppColors.textSecondary)
        }
        .padding()
    }
    
    var teamsRow: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(indexedTeams) { (t: IndexedTeam) in
                    let teamNumber = t.id + 1
                    TeamBox(
                        name: t.name,
                        isActive: draftState.currentTeamIndex(settings: settings) == t.id,
                        isUser: settings.draftPosition == teamNumber
                    )
                }

            }
            .padding(.horizontal)
        }
        .padding(.bottom, 8)
    }



    
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppColors.textSecondary)
            TextField("Search players...", text: $searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(AppColors.textPrimary)
        }
        .padding(10)
        .background(AppColors.secondaryBackground)
        .cornerRadius(8)
        .padding(.horizontal)
    }
    
    var suggestionsList: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Top Suggestions")
                .font(AppFonts.heading(size: 16))
                .foregroundColor(AppColors.textPrimary)
            
            ForEach(topSuggestions) { player in
                PlayerCard(player: player) {
                    draftState.draftPlayer(player, settings: settings)
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal)
    }
    
    struct PlayerBox: View {
        let shortName: String
        let position: String
        
        var body: some View {
            VStack(spacing: 4) {
                Text(shortName)
                    .font(AppFonts.body(size: 12))
                    .foregroundColor(AppColors.textPrimary)
                
                Text(position)
                    .font(AppFonts.body(size: 10))
                    .foregroundColor(AppColors.textSecondary)
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 8)
            .background(AppColors.secondaryBackground)
            .cornerRadius(8)
        }
    }
    
    private func shortPlayerName(_ fullName: String) -> String {
        let parts = fullName.split(separator: " ")
        guard let first = parts.first else { return fullName }
        guard let last = parts.dropFirst().first else { return String(first) }

        let firstInitial = first.prefix(1)
        var lastName = String(last)
        if lastName.count > 8 {   // truncate long names like Antetokounmpo
            lastName = String(lastName.prefix(6)) + "…"
        }
        return "\(firstInitial). \(lastName)"
    }
        
    
    var footer: some View {
        let activeTeam = draftState.currentTeam(settings: settings)
        let activePlayers = draftState.drafted[activeTeam, default: []]

        return VStack(alignment: .leading, spacing: 8) {
            Text("\(activeTeam) is on the clock")
                .font(AppFonts.heading(size: 16))
                .foregroundColor(.white)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(activePlayers) { player in
                        PlayerBox(
                            shortName: shortPlayerName(player.name),
                            position: player.position
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 8)
        .background(AppColors.accent)
        .cornerRadius(8)
        .padding(.horizontal)
        .padding(.bottom, 12)
    }


}


// MARK: - Helpers
private func comparePlayers(_ lhs: Player, _ rhs: Player) -> Bool {
    lhs.projectedPoints > rhs.projectedPoints
}

// MARK: - Subviews
struct PlayerCard: View {
    let player: Player
    let onDraft: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(player.name)
                    .font(AppFonts.heading(size: 14))
                    .foregroundColor(AppColors.textPrimary)
                Text(player.position)
                    .font(AppFonts.body(size: 12))
                    .foregroundColor(AppColors.textSecondary)
            }
            Spacer()
            Button("Draft", action: onDraft)
                .font(AppFonts.body(size: 14))
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(AppColors.accent)
                .cornerRadius(6)
        }
        .padding()
        .background(AppColors.secondaryBackground)
        .cornerRadius(10)
    }
}

struct TeamBox: View {
    let name: String
    let isActive: Bool
    let isUser: Bool
    
    var body: some View {
        Text(name)
            .font(AppFonts.body(size: 12))
            .foregroundColor(isActive ? .white : AppColors.textSecondary)
            .padding(.vertical, 8)
            .frame(width: 70)
            .background(isActive ? AppColors.accent : AppColors.secondaryBackground)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isUser ? AppColors.accent : AppColors.border, lineWidth: 2)
            )
    }
}
