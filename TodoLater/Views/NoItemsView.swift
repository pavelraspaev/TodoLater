//
//  NoItemsView.swift
//  TodoLater
//
//  Created by Pavel Raspaev on 01.06.2022.
//

import SwiftUI

struct NoItemsView: View {
    
    @State var animate: Bool = false
    
    var body: some View {
            VStack(alignment: .center, spacing: 8) {
                Text("There are no items")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text("Come on dude. Lets add some crazy stuff to this list for later!")
                    .foregroundColor(.gray)
                NavigationLink {
                    AddView()
                } label: {
                    Text("Add for later")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(animate ? Color.red : Color.accentColor)
                        .cornerRadius(8)
                        .padding(.top, 48)
                }

            }
            .frame(maxWidth: 400)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 48)
            .onAppear(perform: addAnimation)
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NoItemsView()
                .navigationTitle("Title")
        }
    }
}
