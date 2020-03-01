//
//  AppColors.swift
//  seco
//
//  Created by Alejandro Fornés Gandía on 02/02/2019.
//  Copyright © 2017 08APO0516ja. All rights reserved.
//

import Foundation
import UIKit.UIColor

// App Colors

struct AppColors {

    struct Interface {
        static let white = UIColor(rgbaValue: 0xFFFFFFFF)
        static let black = UIColor(rgbaValue: 0x000000ff)
        static let lightBrown = UIColor(rgbaValue: 0xd9cbacff)
        static let whiteStained = UIColor(rgbaValue: 0xefefefFF)
        static let clear = UIColor.clear
        static let cement = UIColor(rgbaValue: 0x949493FF)
        static let blue = UIColor(rgbaValue: 0x007AFFFF)
        static let red = UIColor(rgbaValue: 0xff0000ff)
    }

    // MARK: - PersonsList
    struct PersonsList {
        static let firstFontColor   = AppColors.Interface.white
        static let emailFontColor   = AppColors.Interface.white
        static let background       = AppColors.Interface.black
        static let titleFontColor   = AppColors.Interface.white
    }

    // MARK: - PersonDetail
    struct PersonDetail {
        static let fontColor                = AppColors.Interface.black
        static let background               = AppColors.Interface.white
        static let buttonBackgroundColor    = AppColors.Interface.red
    }
}

typealias Color = UIColor

extension Color {
    convenience init(rgbaValue: UInt32) {
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

enum ColorName {
    case coffee
    case water

    var rgbaValue: UInt32 {
        switch self {
        case .coffee:
            return 0x321914
        case .water:
            return 0xc48764
        }
    }

    var color: Color {
        return Color(named: self)
    }
}
// swiftlint:enable type_body_length

extension Color {
    convenience init(named name: ColorName) {
        self.init(rgbaValue: name.rgbaValue)
    }
}
