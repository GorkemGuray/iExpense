//
//  ContentView.swift
//  iExpense
//
//  Created by Görkem Güray on 26.03.2024.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    let id = UUID()
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
    @State private var showingAddExpense = false
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(expenses.items) {item in
                    Text(item.name)
                    
                }//ForEach
                .onDelete(perform: removeItems)
            }//List
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }//Button
            }//toolbar
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            
        }//NavigationStack

    }//body
}

#Preview {
    ContentView()
}
