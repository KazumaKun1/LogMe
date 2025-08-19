//
//  Font+Adaptive.swift
//  LogMe
//
//  Created by Arviejhay Alejandro on 8/19/25.
//

import SwiftUI

extension Font {
    private static var availableFonts: [String] = {
        UIFont.familyNames.flatMap { UIFont.fontNames(forFamilyName: $0) }
    }()

    static func adaptive(randomized: Bool = false, sizeClass: UserInterfaceSizeClass?, baseSize: CGFloat = 35, compactSize: CGFloat = 20) -> Font {
        if randomized {
            let fontName = availableFonts.randomElement() ?? ".SFUI"
            let size = (sizeClass == .regular) ? baseSize : compactSize
            return .custom(fontName, size: size)
        } else {
            return (sizeClass == .regular) ? .largeTitle : .title3
        }
    }
}
