//
//  SectionView.swift
//  iExpense
//
//  Created by Görkem Güray on 9.04.2024.
//

import SwiftUI

struct SectionView: View {
    var expenses: Expenses
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    var body: some View {
        ForEach(expenses.items) {item in
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.type)
                }//VStack
                
                Spacer()
                if item.amount < 10 {
                    Text(item.amount, format: .currency(code: item.currency))
                        .foregroundStyle(.green)
                } else if item.amount < 100 {
                    Text(item.amount, format: .currency(code: item.currency))
                        .foregroundStyle(.blue)
                } else {
                    Text(item.amount, format: .currency(code: item.currency))
                        .foregroundStyle(.red)
                }
                
            }//HStack
        }//ForEach
        .onDelete(perform: removeItems)
    }
}

#Preview {
    SectionView(expenses: Expenses())
}
