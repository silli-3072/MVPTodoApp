//
//  TodoListViewController.swift
//  MVPTodoApp
//
//  Created by 春田実利 on 2023/04/29.
//

import UIKit

class TodoListViewController: UIViewController {
    
    private var presenter: TodoListPresenterInput!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var newItemTextField: UITextField!
    
    func inject (presenter: TodoListPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        presenter.viewDidLoad()
        
    }
    
    @IBAction func tappedAddButton() {
        if !newItemTextField.text!.isEmpty {
            presenter.addNewItem(itemContent: newItemTextField.text!)
            newItemTextField.text = ""
        }
    }
    
}

extension TodoListViewController: TodoListPresenterOutput {
    func updateItems() {
        tableView.reloadData()
    }
    
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = presenter.item(forRow: indexPath.row)
        
        return cell
    }
    
}

extension TodoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.didEditingDelete(at: indexPath)
        }
    }
    
}
