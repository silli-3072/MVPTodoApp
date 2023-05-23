//
//  TodoListPresenter.swift
//  MVPTodoApp
//
//  Created by 春田実利 on 2023/04/29.
//

import Foundation

protocol TodoListPresenterInput {
    var numberOfItems: Int{get}
    func item(forRow row: Int) -> String?
    func addNewItem(itemContent: String)
    func didEditingDelete(at indexPath: IndexPath)
    func viewDidLoad()
}

protocol TodoListPresenterOutput: AnyObject {
    func updateItems()
}

final class TodoListPresenter: TodoListPresenterInput {
    
    private(set) var items: [String] = []
    
    private weak var view: TodoListPresenterOutput!
    private var model: TodoModelInput
    
    init(view: TodoListPresenterOutput, model: TodoModelInput) {
        self.view = view
        self.model = model
    }
    
    var numberOfItems: Int {
        return items.count
    }
    
    func item(forRow row: Int) -> String? {
        guard row < items.count else {
            return nil
        }
        return items[row]
    }
    
    func addNewItem(itemContent: String) {
        model.addItem(itemContent: itemContent) {
            items = model.fetchItems()
            view.updateItems()
        }
    }
    
    func didEditingDelete(at indexPath: IndexPath) {
        model.deleteItem(at: indexPath.row) {
            items = model.fetchItems()
            view.updateItems()
        }
    }
    
    func viewDidLoad() {
        items = model.fetchItems()
    }
}
