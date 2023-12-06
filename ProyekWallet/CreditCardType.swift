//
//  CreditCardType.swift
//  ProyekWallet
//
//  Created by Kelvin Sidharta Sie on 05/12/23.
//

import SwiftUI

enum CreditCardType: String, Decodable, Encodable{
    case visa
    case masterCard
    case amex
    
    var gradient : Gradient{
        switch self {
        case .visa:
            return Gradient(colors: [Color.random(), Color.random()])
        case .masterCard:
            return Gradient(colors: [Color.random(), Color.random()])
        case .amex:
            return Gradient(colors: [Color.random(), Color.random()])
        }
    }
    
    var imageName : String{
        switch self{
            case .visa:
                return "visa"
            case .masterCard:
                return "mastercard"
            case .amex:
                return "amex"
        }
    }
}

extension Color {
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
