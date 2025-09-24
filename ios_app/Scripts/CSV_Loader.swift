import Foundation

func loadPlayers() -> [Player] {
    guard
        let linearURL = Bundle.main.url(forResource: "linear_pred_2025", withExtension: "csv"),
        let mcURL = Bundle.main.url(forResource: "monte_carlo_results", withExtension: "csv"),
        let linearData = try? String(contentsOf: linearURL, encoding: .utf8),
        let mcData = try? String(contentsOf: mcURL, encoding: .utf8)
    else {
        return []
    }
    
    let linearRows = linearData.components(separatedBy: .newlines).dropFirst()
    let mcRows = mcData.components(separatedBy: .newlines).dropFirst()
    
    // Build dict from Monte Carlo keyed by NAME
    var mcDict: [String: (Double, Double, Double)] = [:]
    for row in mcRows {
        let cols = row.components(separatedBy: ",")
        if cols.count >= 9 {
            let name = cols[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let std = Double(cols[4]) ?? 0   // MC_std
            let p10 = Double(cols[6]) ?? 0   // MC_p10
            let p90 = Double(cols[8]) ?? 0   // MC_p90
            mcDict[name.uppercased()] = (std, p10, p90)
        }
    }
    
    var players: [Player] = []
    for row in linearRows {
        let cols = row.components(separatedBy: ",")
        if cols.count >= 6 {
            let name = cols[0].trimmingCharacters(in: .whitespacesAndNewlines)
            let team = cols[1]
            let pos = cols[2]
            let projected = Double(cols[6]) ?? 0  // FP_total_pred or FPpG depending on file
            
            let mcStats = mcDict[name.uppercased()] ?? (0, 0, 0)
            
            players.append(Player(
                name: name,
                team: team,
                position: pos,
                projectedPoints: projected,
                mcStd: mcStats.0,
                mcP10: mcStats.1,
                mcP90: mcStats.2
            ))
        }
    }
    
    return players
}

