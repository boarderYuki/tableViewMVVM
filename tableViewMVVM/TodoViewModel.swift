//
//  TodoViewModel.swift
//  tableViewMVVM
//
//  Created by yuki.pro on 2018. 6. 15..
//  Copyright © 2018년 yuki. All rights reserved.
//

protocol TodoItemViewDelegate {
    func onItemSelected() -> (Void)
}

protocol TodoItemPresentable {
    var id: String? { get }
    var textValue: String? { get }
}

class TodoItemViewModel: TodoItemPresentable {
    var id: String? = "0"
    var textValue: String?
    
    init(id: String, textValue: String) {
        self.id = id
        self.textValue = textValue
    }
}

extension TodoItemViewModel: TodoItemViewDelegate {
    
    func onItemSelected() {
        print("did select row id = \(id!)")
    }
    
    
}

protocol TodoViewDelegate {
    func onAddTodoItem() -> ()
    func onDeleteItem(todoId: String) -> ()
}

protocol TodoViewPresentable {
    var newTodoItem: String? { get }
}

class TodoViewModel: TodoViewPresentable {
    
    weak var view: TodoView?
    var newTodoItem: String?
    var items: [TodoItemPresentable] = []
    
    init(view: TodoView) {
        self.view = view
        let item1 = TodoItemViewModel(id: "1", textValue: "할일 1번")
        let item2 = TodoItemViewModel(id: "2", textValue: "할일 2번")
        let item3 = TodoItemViewModel(id: "3", textValue: "할일 3번")
        
        items.append(contentsOf: [item1, item2, item3])
    }
    
    
}

extension TodoViewModel: TodoViewDelegate {
    
    
    func onAddTodoItem() {
        //print("new todo value received \(newTodoItem)")
        
        guard let newValue = newTodoItem else {
            print("new value empty")
            return
        }
        
        let itemIndex = items.count + 1
        let newItem = TodoItemViewModel(id: "\(itemIndex)", textValue: newValue)
        self.items.append(newItem)
        self.newTodoItem = ""
        self.view?.insertTodoItem()
    }
    
    func onDeleteItem(todoId: String) {
        guard let index = self.items.index(where: { $0.id! == todoId }) else {
            print("인덱스 아이템 없음")
            return
        }
        self.items.remove(at: index)
        self.view?.removeTodoItem(at: index)
    }
}

