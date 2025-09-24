import SwiftUI

struct Player: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let team: String
    let position: String
    let projectedPoints: Double
    let mcStd: Double             // volatility → risk
    let mcP10: Double             // downside (10th percentile)
    let mcP90: Double             // upside (90th percentile)
}

final class DraftState: ObservableObject {
    @Published var availablePlayers: [Player] = []
    @Published var drafted: [String: [Player]] = [:]   // team → list of players
    @Published var currentRound: Int = 1
    @Published var currentPickIndex: Int = 0

    private var maxRounds: Int

    init(players: [Player], maxRounds: Int = 12) {
        self.availablePlayers = players
        self.maxRounds = maxRounds
    }

    /// Index of the team that’s currently on the clock (0-based, snake order).
    func currentTeamIndex(settings: DraftSettings) -> Int {
        guard !settings.teams.isEmpty else { return 0 }

        if currentRound % 2 == 1 {
            // odd round → normal order
            return currentPickIndex
        } else {
            // even round → reverse order
            return settings.teams.count - 1 - currentPickIndex
        }
    }

    /// Name of the team that’s currently on the clock.
    func currentTeam(settings: DraftSettings) -> String {
        guard !settings.teams.isEmpty else { return "" }
        return settings.teams[currentTeamIndex(settings: settings)]
    }

    /// Draft a player for the current team.
    func draftPlayer(_ player: Player, settings: DraftSettings) {
        let team = currentTeam(settings: settings)
        drafted[team, default: []].append(player)
        availablePlayers.removeAll { $0 == player }
        advance(settings: settings)
    }

    private func advance(settings: DraftSettings) {
        if currentPickIndex < settings.teams.count - 1 {
            currentPickIndex += 1
        } else {
            currentPickIndex = 0
            currentRound += 1
        }
    }
}
