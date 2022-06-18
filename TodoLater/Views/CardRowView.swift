//
//  CardRowView.swift
//  TodoLater
//
//  Created by Pavel Raspaev on 31.05.2022.
//

import SwiftUI

struct CardRowView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var task: Task
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                .foregroundColor(task.isCompleted ? .gray.opacity(0.5) : .black)
            Text(task.name ?? "")
                .font(.subheadline)
                .foregroundColor(task.isCompleted ? .gray.opacity(0.5) : .black)
                .strikethrough(task.isCompleted, color: .gray.opacity(0.5))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.clear)
                .onTapGesture {
                    withAnimation {
                        homeViewModel.completeTask(task)
                    }
                }
            Spacer()
            
            if task.isCompleted {
                Image(systemName: "trash")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.gray.opacity(0.5))
                    .onTapGesture {
                        withAnimation {
                            homeViewModel.deleteTask(task)
                        }
                    }
            }
            
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
}

struct ListRowView_Previews: PreviewProvider {

    static var previews: some View {
        let context = HomeViewModel().container.viewContext
        let newTask = Task.init(context: context)
        newTask.id = UUID()
        newTask.name = "Potatoes"
        newTask.type = "personal"
        newTask.isCompleted = false
        
        return CardRowView(task: newTask).padding(16).background(RoundedRectangle(cornerRadius: 18, style: .circular).fill(.blue.opacity(0.1))).padding(24)
    }
}
