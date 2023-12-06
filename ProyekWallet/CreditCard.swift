//
//  CreditCard.swift
//  ProyekWallet
//
//  Created by Kelvin Sidharta Sie on 05/12/23.
//

import Foundation

struct CreditCard : Hashable, Decodable, Encodable{
    var uniqueKey: String
    
    var cardType : CreditCardType
    var bankName : String
    var urlCompany : String
    var cardHolderName : String
    var email: String
    var companyName: String
    var phone : String
    
    init(cardType: CreditCardType, bankName: String, urlCompany: String, cardHolderName: String, email: String, companyName: String, phone: String) {
           self.uniqueKey = UUID().uuidString
            
            let cardTypes: [CreditCardType] = [.amex, .visa, .masterCard]
            let randomCardType = cardTypes.randomElement() ?? .visa
            self.cardType = randomCardType
    
           self.bankName = bankName
           self.urlCompany = urlCompany
           self.cardHolderName = cardHolderName
           self.email = email
           self.companyName = companyName
           self.phone = phone
       }
}

//let sampleCards: [CreditCard] = [
//    CreditCard(cardType: .visa, bankName: "Bank Kelvin", urlCompany: "companya.com", cardHolderName: "Kelvin Sidharta Sie", email: "kelvinsidhartasie@gmail.com", companyName: "Company A", phone: "081218216023")
//]
