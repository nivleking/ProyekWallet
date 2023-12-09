//
//  CreditCardViewModel.swift
//  ProyekWallet
//
//  Created by Kelvin Sidharta Sie on 05/12/23.
//

import SwiftUI
import FirebaseDatabase
import FirebaseDatabaseSwift

class CreditCardViewModel: ObservableObject {
    @Published var creditCards: [CreditCard] = []
    @Published var currentEditingCard: CreditCard?
    
    private let ref = Database.database().reference()

    init() {
        //UserDefaults
//        loadCreditCards()
        
        //Firebase
        loadCreditCardsFromFirebase()
    }
    
    func saveCreditCardToFirebase(_ card: CreditCard) {
        do {
            let data = try JSONEncoder().encode(card)
            let cardDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

            let uniqueKey = card.uniqueKey

            ref.child("creditCards").child(uniqueKey).setValue(cardDictionary)
        } catch {
            print("Error encoding or saving credit card to Firebase: \(error)")
        }
    }
    
    func loadCreditCardsFromFirebase() {
        ref.child("creditCards").observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let cardDictionary = childSnapshot.value as? [String: Any] {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: cardDictionary)
                        let card = try JSONDecoder().decode(CreditCard.self, from: data)
                        self.creditCards.append(card)
                    } catch {
                        print("Error decoding credit card: \(error)")
                    }
                }
            }
        })
    }

    
    func deleteCreditCardFromFirebase(_ card: CreditCard) {
        let uniqueKey = String(card.uniqueKey)
        
        let creditCardsRef = ref.child("creditCards")
        
        let cardRef = creditCardsRef.child(uniqueKey)
//        print(cardRef)
        cardRef.removeValue { error, _ in
            if let error = error {
                print("Error deleting credit card from Firebase: \(error)")
            } else {
                print("Credit card deleted from Firebase successfully.")
            }
        }
    }
    
    func updateCreditCardInFirebase(_ existingCard: CreditCard, with newCard: CreditCard) {
        let uniqueKey = String(existingCard.uniqueKey)

        let creditCardsRef = ref.child("creditCards")
        let cardRef = creditCardsRef.child(uniqueKey)

        do {
            let data = try JSONEncoder().encode(newCard)
            let cardDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

            if let unwrappedCardDictionary = cardDictionary {
                cardRef.updateChildValues(unwrappedCardDictionary) { error, _ in
                    if let error = error {
                        print("Error updating credit card in Firebase: \(error)")
                    } else {
                        print("Credit card updated in Firebase successfully.")
                    }
                }
            } else {
                print("Error: Unable to unwrap cardDictionary")
            }
        } catch {
            print("Error encoding or updating credit card in Firebase: \(error)")
        }
    }

    func saveCreditCards() {
        do {
            let data = try JSONEncoder().encode(creditCards)
            UserDefaults.standard.set(data, forKey: "creditCards")
        } catch {
            print("Error encoding credit cards: \(error)")
        }
    }

    func loadCreditCards() {
        if let data = UserDefaults.standard.data(forKey: "creditCards") {
            do {
                creditCards = try JSONDecoder().decode([CreditCard].self, from: data)
            } catch {
                print("Error decoding credit cards: \(error)")
            }
        }
    }

    func addCreditCard(_ card: CreditCard) {
        let cardWithKey = CreditCard(cardType: card.cardType, bankName: card.bankName, urlCompany: card.urlCompany, cardHolderName: card.cardHolderName, email: card.email, companyName: card.companyName, phone: card.phone)

        creditCards.append(cardWithKey)
        saveCreditCards()
        saveCreditCardToFirebase(cardWithKey)
    }
    
    
    func removeCreditCard(_ card: CreditCard) {
        if let index = creditCards.firstIndex(of: card) {
            creditCards.remove(at: index)
            deleteCreditCardFromFirebase(card)
            saveCreditCards()
        }
    }
    
    func updateCreditCard(_ existingCard: CreditCard, with newCard: CreditCard) {
        if let index = creditCards.firstIndex(of: existingCard) {
            creditCards[index] = newCard
            saveCreditCards()
        }
    }
    
    func updateCreditCards() {
       objectWillChange.send()
    }
}
