//
//  CardView.swift
//  TodoLater
//
//  Created by Pavel Raspaev on 07.06.2022.
//

import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var cardType: CardType
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .top) {
                Circle()
                    .strokeBorder(.black.opacity(0.1), lineWidth: 1)
                    .frame(width: 48, height: 48)
                    .overlay(
                        cardType.linearGradient
                            .mask({
                                Image(cardType.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                            })
                    )
                    .padding(.bottom, 24)
                Spacer()
                if cardIsDone(for: cardType) {
                    Image("done")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.green)
                        .frame(width: 16, height: 16)
                    .padding(.bottom, 24)
                } else {
                    EmptyView()
                }
            }
            
            Text("Tasks: \(cardTasks(for: cardType).count)")
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.4))
                .padding(.bottom, 4)
            
            Text(cardType.name)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .padding(.bottom, 24)
            
            if cardTasks(for: cardType).isEmpty {
                
                VStack {
                    
                    LottieView(lottieFile: cardType.animation)
                        .frame(width: 150, height: 150)
                        .padding(.bottom, 24)
                    
                    Text("There is no tasks")
                        .font(.headline)
                        .padding(.bottom, 8)
                    
                    Text("Add something for later or we will find you... and hug you")
                        .font(.caption)
                        .foregroundColor(.black.opacity(0.3))
                        .multilineTextAlignment(.center)

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(40)
                .offset(x: 0, y: -50)
                
            } else {
                
                ScrollView(showsIndicators: false) {
                    ForEach(cardTasks(for: cardType)) { task in
                        CardRowView(task: task)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .foregroundColor(.black)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .circular)
                    .fill(.white)
                if cardTasks(for: cardType).isEmpty {
                    EmptyView()
                } else {
                    VStack {
                        ProgressView(value: Double(cardCompletedTasks(for: cardType).count),
                                     total: Double(cardTasks(for: cardType).count))
                            .tint(cardIsDone(for: cardType) ? .green : cardType.color)
                            .opacity(cardTasks(for: cardType).isEmpty ? 0 : 0.1)
                            .scaleEffect(x: 1, y: 500, anchor: .center)
                    }
                }
            }
        )
        .cornerRadius(8)
    }
    
    // MARK: METHODS
    func cardTasks(for card: CardType) -> [Task] {
        return homeViewModel.tasks.filter({ $0.type == cardType.name })
    }
    
    func cardCompletedTasks(for card: CardType) -> [Task] {
        return cardTasks(for: card).filter({ $0.isCompleted })
    }
    
    func cardIsDone(for card: CardType) -> Bool {
        if cardTasks(for: card).count == cardCompletedTasks(for: card).count
            && cardTasks(for: card).isEmpty == false {
            return true
        }
        return false
    }
    
}


struct Card_Previews: PreviewProvider {

    static var previews: some View {
        ZStack {
            Color.linearGradients.house
                .ignoresSafeArea()

            CardView(cardType: .house)
                .padding(32)

        }
        .environmentObject(HomeViewModel())

    }
}
