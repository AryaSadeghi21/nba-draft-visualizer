//
//  DraftSettings.swift
//  Draft_Playbook
//
//  Created by Arya Arya on 9/23/25.
//


import SwiftUI

class DraftSettings: ObservableObject {
    @Published var draftType: String = "Snake"
    @Published var numTeams: Int = 0
    @Published var draftPosition: Int = 0
    @Published var teams: [String] = []
    @Published var userTeam: Int = 1
    
    func generateTeams() {
        teams = (1...numTeams).map { "Team \($0)" }
        userTeam = draftPosition
    }
}
