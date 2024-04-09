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
    @State private var currency = "USD"
    
    @Environment(\.dismiss) var dismiss
    
    var businessExpenses: Expenses
    var personalExpenses: Expenses
    
    let types = ["Business", "Personal"]
    let currencyList = ["USD", "EUR", "GBP", "TRY", "CNY"]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach (types, id: \.self) {
                        Text($0)
                    } //ForEach
                } //Picker
                HStack {
                    TextField("Amount", value: $amount, format: .currency(code: currency))
                    //TextField("Amount", value: $amount, format: .)
                        .keyboardType(.decimalPad)
                    
                    Picker("Currency", selection: $currency) {
                        ForEach (currencyList, id: \.self) {
                            Text($0)
                        }//ForEach
                    }//Picker
                    .labelsHidden()
                }//HStack
                
            } //Form
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                   let item = ExpenseItem(name: name, type: type, amount: amount, currency: currency)
                    if item.type == "Business" {
                        businessExpenses.items.append(item)
                    } else {
                        personalExpenses.items.append(item)
                    }
                    
                    dismiss()
                }
            }
            
        } //NavigationStack
    }
}

#Preview {
    AddView(businessExpenses: Expenses(), personalExpenses: Expenses())
}
