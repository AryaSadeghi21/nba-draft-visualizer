//
//  ContentView.swift
//  Draft_Playbook
//
//  Created by Arya Arya on 9/22/25.
//



import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // Top bar
            HStack {
                Spacer()
                Text("Home")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.leading, 12)
                Spacer()
                Button(action: {
                    // Settings action
                }) {
                    Image(systemName: "gearshape")
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                }
                .frame(width: 48, height: 48, alignment: .trailing)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color(hex: "#181411"))

            Spacer().frame(height: 16)

            // Title + subtitle
            Text("Welcome to Draft")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 8)
                .multilineTextAlignment(.center)

            Text("Start a new draft to begin building your dream team.")
                .font(.system(size: 16))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.bottom, 24)

            // Start button
            Button(action: {
                // Start draft action
            }) {
                Text("Start a New Draft")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#f26c0d"))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 16)

            Spacer()

            // Bottom tab bar
            HStack {
                TabItem(icon: "house.fill", label: "Home", active: true)
                TabItem(icon: "doc", label: "Draft")
                
                
            }
            .padding(.vertical, 8)
            .background(Color(hex: "#27201b"))

            Rectangle()
                .fill(Color(hex: "#27201b"))
                .frame(height: 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hex: "#181411"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct TabItem: View {
    let icon: String
    let label: String
    var active: Bool = false

    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(active ? .white : Color(hex: "#baa89c"))
                .frame(height: 24)
            Text(label)
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(active ? .white : Color(hex: "#baa89c"))
        }
        .frame(maxWidth: .infinity)
    }
}

// Helper to use hex colors
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, (int >> 16) & 0xff, (int >> 8) & 0xff, int & 0xff)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = ((int >> 24) & 0xff, (int >> 16) & 0xff, (int >> 8) & 0xff, int & 0xff)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    ContentView()
}

