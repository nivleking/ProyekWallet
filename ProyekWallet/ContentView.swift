//
//  ContentView.swift
//  ProyekWallet
//
//  Created by Kelvin Sidharta Sie on 05/12/23.
//

import SwiftUI
import SwiftUIFontIcon

struct ContentView: View {
    @StateObject private var viewModel = CreditCardViewModel()
    @State private var isAddingCard = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Cards")
                    .font(.system(size: 32, weight: .bold))
                Spacer()
                AddCreditCardView(isAddingCard: $isAddingCard)
            }
            .padding(.top, 32)
            .padding(.trailing, 32)
            .padding(.leading,32)
            
           
            if viewModel.creditCards.isEmpty {
                Text("No cards available. Add a new card.")
                    .foregroundColor(.black)
                    .padding()
            } else {
                TabView {
                    ForEach(viewModel.creditCards, id: \.self) { card in
                        CreditCardView(creditCard: card, viewModel: viewModel)
                            .padding(.bottom, 50)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 280)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .padding(.horizontal, 16)
            }
            Spacer()
        }
        .sheet(isPresented: $isAddingCard) {
            AddCardView(viewModel: viewModel, isPresented: $isAddingCard)
        }
        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
    }
}

struct ActionCreditCardButtonView: View {
    let icon : FontAwesomeCode
    var body: some View {
        FontIcon.button(.awesome5Solid(code: icon), action: {
            
        },fontsize: 12)
            .padding(12)
            .background(.black)
            .cornerRadius(32)
    }
}

struct CreditCardView: View {
    let creditCard: CreditCard
    @ObservedObject var viewModel: CreditCardViewModel
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 16){
            HStack{
                Image(creditCard.cardType.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80,height: 80)
                    .clipped()
                Spacer()
                VStack{
                    HStack{
                        ActionCreditCardButtonView(icon: .pencil_alt)
                        .onTapGesture {
                            isEditing = true;
                            }
                        ActionCreditCardButtonView(icon: .trash)
                        .onTapGesture {
                            viewModel.removeCreditCard(creditCard)
                        }
                    }
                    Text(creditCard.bankName)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
            }
            
            HStack(spacing:8){
                VStack(alignment:.leading) {
                    Text("Company")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text(creditCard.companyName)
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                    
                    Text(creditCard.urlCompany)
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                }
                Spacer()
                VStack(alignment:.leading) {
                    Text("Phone")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    Text(creditCard.phone)
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                }
            }
            
            HStack(spacing: 8){
                VStack(alignment: .leading){
                    Text("Name")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text(creditCard.cardHolderName)
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                }
                Spacer()
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                    
                    Text(creditCard.email)
                        .font(.system(size: 12))
                        .fontWeight(.regular)
                }
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(
            LinearGradient(gradient: creditCard.cardType.gradient, startPoint: .leading, endPoint: .trailing)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.secondary.opacity(0.5),lineWidth: 1.5)
                )
        )
        .sheet(isPresented: $isEditing) {
            EditCardView(viewModel: viewModel, isPresented: $isEditing, editingCard: creditCard)
        }
        .cornerRadius(16)
        .padding(.horizontal)
        .padding(.top,8)
    }
}

struct AddCreditCardView: View {
    @Binding var isAddingCard: Bool
    
    var body: some View {
        FontIcon.button(.awesome5Solid(code: .plus), action: {
            isAddingCard = true
        },fontsize: 16)
            .padding(12)
            .background(.black)
            .foregroundColor(.white)
            .cornerRadius(32)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
