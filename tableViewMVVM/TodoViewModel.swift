//
//  TodoViewModel.swift
//  tableViewMVVM
//
//  Created by yuki.pro on 2018. 6. 15..
//  Copyright © 2018년 yuki. All rights reserved.
//

protocol TodoItemPresentable {
    var id: String? { get }
    var textValue: String? { get }
}

struct TodoItemViewModel: TodoItemPresentable {
    var id: String? = "0"
    var textValue: String?
}

protocol TodoItemViewDelegate {
    func onTodoItemAdd() -> ()
}

struct TodoViewModel {
    
    init() {
        let item1 = TodoItemViewModel(id: "1", textValue: "할일 1번")
        let item2 = TodoItemViewModel(id: "2", textValue: "할일 2번")
        let item3 = TodoItemViewModel(id: "3", textValue: "할일 3번")
        
        items.append(contentsOf: [item1, item2, item3])
    }
    
    var newTodoItem: String?
    var items: [TodoItemPresentable] = []
}

extension TodoViewModel: TodoItemViewDelegate {
    func onTodoItemAdd() {
        
    }
}
