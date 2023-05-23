//
//  TodoModel.swift
//  MVPTodoApp
//
//  Created by 春田実利 on 2023/04/29.
//

import Foundation

protocol TodoModelInput {
    func fetchItems() -> [String]
    func addItem(itemContent: String, completion: () -> ())
    func deleteItem(at index: Int, completion: () -> ())
}

final class TodoModel: TodoModelInput {
    
    private let userDefaluts = UserDefaults.standard
    private let ITEM_KEY = "TodoItems"
    private let item1 = "item1"
    
    func fetchItems() -> [String] {
        return userDefaluts.array(forKey: ITEM_KEY) as? [String] ?? [item1]
    }
    
    func addItem(itemContent: String, completion: () -> ()) {
        var items = userDefaluts.array(forKey: ITEM_KEY) as! [String]
        items.append(itemContent)
        userDefaluts.set(items, forKey: ITEM_KEY)
        completion()
    }
    
    func deleteItem(at index: Int, completion: () -> ()) {
        var items = userDefaluts.array(forKey: ITEM_KEY) as! [String]
        items.remove(at: index)
        userDefaluts.set(items, forKey: ITEM_KEY)
        completion()
    }
}
