//
//  EditCardView.swift
//  ProyekWallet
//
//  Created by Kelvin Sidharta Sie on 05/12/23.
//

import SwiftUI

struct EditCardView: View {
    @ObservedObject var viewModel: CreditCardViewModel
    @Binding var isPresented: Bool
    var editingCard: CreditCard

    @State private var updatedCard: CreditCard

    init(viewModel: CreditCardViewModel, isPresented: Binding<Bool>, editingCard: CreditCard) {
        self.viewModel = viewModel
        self._isPresented = isPresented
        self.editingCard = editingCard

        self._updatedCard = State(initialValue: editingCard)
    }

    var body: some View {
        NavigationView {
            Form {
                VStack {
                    TextField("Bank Name", text: $updatedCard.bankName)
                        .padding(.bottom,8)
                    TextField("Company Name", text: $updatedCard.companyName)
                        .padding(.bottom,8)
                    TextField("URL Company", text: $updatedCard.urlCompany)
                        .padding(.bottom,8)
                    TextField("Card Holder Name", text: $updatedCard.cardHolderName)
                        .padding(.bottom,8)
                    TextField("Email", text: $updatedCard.email)
                        .padding(.bottom,8)
                    TextField("Phone", text: $updatedCard.phone)
                        .padding(.bottom,8)

                    Text("Editing \(editingCard.bankName)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Edit Card")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.updateCreditCardInFirebase(editingCard, with: updatedCard)
                        viewModel.updateCreditCard(editingCard, with: updatedCard)
                        viewModel.updateCreditCards()
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
