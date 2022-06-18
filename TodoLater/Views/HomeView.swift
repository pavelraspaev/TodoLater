//
//  HomeView.swift
//  TodoLater
//
//  Created by Pavel Raspaev on 06.06.2022.
//

import SwiftUI
import BottomSheet

public enum BottomSheetPosition: CGFloat, CaseIterable {
    case top = 700, middle = 220, bottom = 150, hidden = 0
}

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    let cards: [CardType] = [.personal, .work, .house]
    
    @State var selectedCard = CardType.personal
    @State var background: Color = CardType.personal.color
    
    @State private var bottomSheetPosition: BottomSheetPosition = .hidden
    
    var body: some View {
        ZStack {
            
            background
                .ignoresSafeArea()
            
            VStack {
                
                // header
                HStack {
                    ZStack(alignment: .trailing) {
                        Text("Laterr")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.headline)
                        
                        Button {
                            withAnimation {
                                bottomSheetPosition = .middle
                            }
                        } label: {
                            Image("add")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                        }
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 32)
                .padding(.bottom, 32)
                
                // title
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text(everythingIsDone() ? "Everything is done" : "\(tasksLeftAmount()) tasks for later")
                        .lineLimit(1)
                        .font(.title.bold())
                        .padding(.bottom, 8)
                    
                    Text(everythingIsDone() ? "And we are disappointed..." : "Laziness must grow")
                        .font(.subheadline)
                        .opacity(0.8)
                
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
                
                // tabs
                TabView(selection: $selectedCard) {
                    
                    ForEach(cards, id: \.self) { card in
                        CardView(cardType: card)
                            .padding(.horizontal, 24)
                            .tag(card)
                    }
                    
                }
                .frame(maxHeight: .infinity)
                .onChange(of: selectedCard) { newValue in
                    withAnimation(.linear(duration: 0.5)) {
                        background = selectedCard.color
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .padding(.bottom, 16)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 12)
                
            }
        }
        .bottomSheet(bottomSheetPosition: self.$bottomSheetPosition, options: [
                .animation(.spring()),
                .background({AnyView(RoundedRectangle(cornerRadius: 16, style: .circular).fill(.white))}),
                .notResizeable,
                .noDragIndicator,
                .swipeToDismiss,
                .tapToDismiss,
                .absolutePositionValue,
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: -4)])
        {
            AddView(selectedCard: $selectedCard, bottomSheetPosition: $bottomSheetPosition)
        }
    }
    
    // MARK: METHODS
    func tasksAmount() -> Int { homeViewModel.tasks.count }
    
    func tasksCompletedAmount() -> Int { homeViewModel.tasks.filter({ $0.isCompleted}).count }
    
    func tasksLeftAmount() -> Int { tasksAmount() - tasksCompletedAmount() }
    
    func everythingIsDone() -> Bool { tasksAmount() == tasksCompletedAmount() }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(HomeViewModel())
    }
}
