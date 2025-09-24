//
//  AppColors.swift
//  Draft_Playbook
//
//  Created by Arya Arya on 9/23/25.
//


import SwiftUI

enum AppColors {
    static let background = Color("#181411")
    static let secondaryBackground = Color("#27201b")
    static let border = Color("#54453b")
    static let accent = Color("#f26c0d")
    static let textPrimary = Color.white
    static let textSecondary = Color("#baa89c")
}

extension Color {
    init(_ hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0; Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6: (a, r, g, b) = (255, (int >> 16) & 0xff, (int >> 8) & 0xff, int & 0xff)
        case 8: (a, r, g, b) = ((int >> 24) & 0xff, (int >> 16) & 0xff, (int >> 8) & 0xff, int & 0xff)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB,
                  red:   Double(r)/255,
                  green: Double(g)/255,
                  blue:  Double(b)/255,
                  opacity: Double(a)/255)
    }
}

enum AppFonts {
    static func heading(size: CGFloat) -> Font {
        .custom("SpaceGrotesk-Bold", size: size) // match exact font file name
    }
    static func body(size: CGFloat) -> Font {
        .custom("SpaceGrotesk-Regular", size: size)
    }
}
