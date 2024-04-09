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
    let currency: String
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
    
    @State private var personalExpenses = Expenses()
    @State private var businessExpenses = Expenses()
    @State private var showingAddExpense = false
    

    
    var body: some View {
        
        NavigationStack {
            List {
                if businessExpenses.items.isEmpty == false {
                    Section("Business") {
                        SectionView(expenses: businessExpenses)
                    }//Section-1
                }
                
                if personalExpenses.items.isEmpty == false {
                    Section("Personal") {
                        SectionView(expenses: personalExpenses)
                    }//Section-2
                }
                
            }//List
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }//Button
            }//toolbar
            .sheet(isPresented: $showingAddExpense) {
                AddView(businessExpenses: businessExpenses, personalExpenses: personalExpenses)
            }
            
        }//NavigationStack

    }//body
}

#Preview {
    ContentView()
}
