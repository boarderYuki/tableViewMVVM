//
//  ViewController.swift
//  tableViewMVVM
//
//  Created by yuki.pro on 2018. 6. 15..
//  Copyright © 2018년 yuki. All rights reserved.
//

import UIKit

protocol TodoView: class {
    func insertTodoItem() -> ()
}

class ViewController: UIViewController {

    @IBOutlet weak var tableViewItems: UITableView!
    @IBOutlet weak var textFieldNewItem: UITextField!
    
    var viewModel: TodoViewModel?
    
    let identifier = "todoItemCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "TodoItemTableViewCell", bundle: nil)
        tableViewItems.register(nib, forCellReuseIdentifier: identifier)
        
        viewModel = TodoViewModel(view: self)
    }

    
    @IBAction func onAddItem(_ sender: Any) {
        guard let newTodoValue = textFieldNewItem.text else {
            print("no value")
            return
        }
        
        viewModel?.newTodoItem = newTodoValue
        viewModel?.onAddTodoItem()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TodoItemTableViewCell
        
        let itemViewModel = viewModel?.items[indexPath.row]
        
        cell?.configure(withViewModel: itemViewModel!)
        
        return cell!
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemViewModel = viewModel?.items[indexPath.row]
        (itemViewModel as? TodoItemViewDelegate)?.onItemSelected()
    }
}

extension ViewController: TodoView {
    
    func insertTodoItem() {
        
        guard let items = viewModel?.items else {
            print("items empty")
            return
        }
        
        self.textFieldNewItem.text = viewModel?.newTodoItem!
        self.tableViewItems.beginUpdates()
        self.tableViewItems.insertRows(at: [IndexPath(row: items.count-1, section: 0)], with: .automatic)
        self.tableViewItems.endUpdates()
    }
    
    
}



