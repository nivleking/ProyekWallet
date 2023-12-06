//
//  AddCardView.swift
//  ProyekWallet
//
//  Created by Kelvin Sidharta Sie on 05/12/23.
//

import SwiftUI

struct AddCardView: View {
    @ObservedObject var viewModel: CreditCardViewModel
    @Binding var isPresented: Bool
    @State private var newCard: CreditCard = CreditCard(cardType: .visa, bankName: "", urlCompany: "", cardHolderName: "", email: "", companyName: "", phone: "")

    var body: some View {
        NavigationView {
            Form() {
                VStack {
                    TextField("Bank Name", text: $newCard.bankName)
                        .padding(.bottom,8)
                    TextField("Company Name", text: $newCard.companyName)
                        .padding(.bottom,8)
                    TextField("URL Company", text: $newCard.urlCompany)
                        .padding(.bottom,8)
                    TextField("Card Holder Name", text: $newCard.cardHolderName)
                        .padding(.bottom,8)
                    TextField("Email", text: $newCard.email)
                        .padding(.bottom,8)
                    TextField("Phone", text: $newCard.phone)
                        .padding(.bottom,8)
                }
            }
            .navigationTitle("Add New Card")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.addCreditCard(newCard)
                        viewModel.updateCreditCards() // Notify the changes
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
}
