//
//  AddView.swift
//  TodoLater
//
//  Created by Pavel Raspaev on 31.05.2022.
//

import SwiftUI
import BottomSheet

struct AddView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    let cards: [CardType] = [.personal, .work, .house]
    
    @State var newTaskName: String = ""
    @Binding var selectedCard: CardType
    @Binding var bottomSheetPosition: BottomSheetPosition
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {

        VStack {
            
            // header
            HStack {
                Text("Add something for later")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    bottomSheetPosition = .hidden
                    UIApplication.shared.endEditing()
                } label: {
                    Image("close")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black.opacity(0.2))
                        .frame(width: 24, height: 24)
                }

            }
            .padding(.horizontal, 8)
            .padding(.top, 8)
            .padding(.bottom, 32)
            .frame(maxWidth: .infinity)
            
            HStack {
                
                ForEach(cards, id: \.self) { card in
                    Image(card.icon)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(selectedCard.name == card.name ? card.color : .black.opacity(0.1))
                        .frame(width: 24, height: 24)
                        .background(
                            Circle()
                                .fill(selectedCard.name == card.name ? card.color.opacity(0.1) : .clear)
                                .frame(width: 56, height: 56)
                        )
                        .overlay(
                            Circle()
                                .strokeBorder(selectedCard.name == card.name ? card.color : .clear)
                                .frame(width: 56, height: 56)
                        )
                        .padding(.horizontal, 24)
                        .onTapGesture {
                            withAnimation {
                                selectedCard = card
                            }
                        }
                }
                
                Spacer()
                
            }
            .padding(.bottom, 24)
            
            ZStack(alignment: .trailing) {
                ZStack(alignment: .leading) {
                    if newTaskName.isEmpty {
                        Text("Type here...")
                            .foregroundColor(.black.opacity(0.3))
                    }
                    TextField("", text: $newTaskName)
                    
                }
                .padding(.horizontal)
                .frame(height: 55)
                .background(.black.opacity(0.1))
                .cornerRadius(20)
                Button {
                    saveButtonPressed()
                } label: {
                    Image("checked")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.accentColor)
                        .frame(width: 40, height: 40)
                        .padding(.trailing, 8)
                }
                .padding(.vertical, 8)
            }
            Spacer()
            

        }
        .foregroundColor(.black)
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(edges: .bottom)
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsValid() {
            homeViewModel.addTask(name: newTaskName, type: selectedCard.name, isCompleted: false)
            newTaskName = ""
        }
    }
    
    func textIsValid() -> Bool {
        if newTaskName.count < 3 {
            alertTitle = "Must be at least 3 characters long"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(selectedCard: .constant(.personal), bottomSheetPosition: .constant(.middle))
            .environmentObject(HomeViewModel())
    }
}
