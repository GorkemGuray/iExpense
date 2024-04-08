//
//  ContentView.swift
//  iExpense
//
//  Created by Görkem Güray on 26.03.2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.value(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems as! Data) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
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
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }//VStack
                        
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }//HStack
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
