//
//  AddView.swift
//  iExpense
//
//  Created by Görkem Güray on 7.04.2024.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach (types, id: \.self) {
                        Text($0)
                    } //ForEach
                } //Picker
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            } //Form
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                   let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
            
        } //NavigationStack
    }
}

#Preview {
    AddView(expenses: Expenses())
}
