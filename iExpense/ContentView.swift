//
//  ContentView.swift
//  iExpense
//
//  Created by Görkem Güray on 26.03.2024.
//

import SwiftUI

struct ExpenseItem {
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]()
}



struct ContentView: View {
    
    @State private var expenses = Expenses()
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(expenses.items, id: \.name) {item in
                    Text(item.name)
                    
                }//ForEach
                .onDelete(perform: removeItems)
            }//List
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                    expenses.items.append(expense)
                }
            }
            
        }//NavigationStack

    }//body
}

#Preview {
    ContentView()
}
