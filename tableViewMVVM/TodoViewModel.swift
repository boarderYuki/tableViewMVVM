//
//  TodoViewModel.swift
//  tableViewMVVM
//
//  Created by yuki.pro on 2018. 6. 15..
//  Copyright © 2018년 yuki. All rights reserved.
//

protocol TodoMenuItemViewPresentable {
    var title: String? {get}
    var backColor: String? {get}
}

protocol TodoMenuItemViewDelegate {
    func onMenuItemSelected() -> ()
}

class TodoMenuItemViewModel: TodoMenuItemViewPresentable, TodoMenuItemViewDelegate {
    var title: String?
    var backColor: String?
    weak var parent: TodoItemViewDelegate?
    
    init(parentViewModel: TodoItemViewDelegate) {
        self.parent = parentViewModel
    }
    
    func onMenuItemSelected() {
        
    }
}

class RemoveMenuItemViewModel: TodoMenuItemViewModel {
    override func onMenuItemSelected() {
        print("remove select")
        parent?.onRemoveSelected()
    }
}

class DoneMenuItemViewModel: TodoMenuItemViewModel {
    override func onMenuItemSelected() {
        print("done select")
        parent?.onDoneSelected()
    }
}

protocol TodoItemViewDelegate: class {
    func onItemSelected() -> (Void)
    func onRemoveSelected() -> (Void)
    func onDoneSelected() -> (Void)
}

protocol TodoItemPresentable {
    var id: String? { get }
    var textValue: String? { get }
    var menuItems: [TodoMenuItemViewPresentable]? {get}
}

class TodoItemViewModel: TodoItemPresentable {
    
    var id: String? = "0"
    var textValue: String?
    var menuItems: [TodoMenuItemViewPresentable]? = []
    weak var parent: TodoViewDelegate?
    
    init(id: String, textValue: String, parentViewModel: TodoViewDelegate) {
        self.id = id
        self.textValue = textValue
        self.parent = parentViewModel
        
        let removeMenuItem = RemoveMenuItemViewModel(parentViewModel: self)
        removeMenuItem.title = "Remove"
        removeMenuItem.backColor = "ff0000"
        
        let doneMenuItem = DoneMenuItemViewModel(parentViewModel: self)
        doneMenuItem.title = "Done"
        doneMenuItem.backColor = "008000"
        
        menuItems?.append(contentsOf: [removeMenuItem, doneMenuItem])
        
    }
}

extension TodoItemViewModel: TodoItemViewDelegate {
    
    func onItemSelected() {
        print("did select row id = \(id!)")
    }
    
    func onRemoveSelected() {
        parent?.onTodoDelete(todoId: id!)
    }
    
    func onDoneSelected() {
        parent?.onTodoDone(todoId: id!)
    }
    
}

protocol TodoViewDelegate: class {
    func onAddTodoItem() -> ()
    func onTodoDelete(todoId: String) -> ()
    func onTodoDone(todoId: String) -> ()
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
        let item1 = TodoItemViewModel(id: "1", textValue: "할일 1번", parentViewModel: self)
        let item2 = TodoItemViewModel(id: "2", textValue: "할일 2번", parentViewModel: self)
        let item3 = TodoItemViewModel(id: "3", textValue: "할일 3번", parentViewModel: self)
        
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
        let newItem = TodoItemViewModel(id: "\(itemIndex)", textValue: newValue, parentViewModel: self)
        self.items.append(newItem)
        self.newTodoItem = ""
        self.view?.insertTodoItem()
    }
    
    func onTodoDelete(todoId: String) {
        guard let index = self.items.index(where: { $0.id! == todoId }) else {
            print("인덱스 아이템 없음")
            return
        }
        self.items.remove(at: index)
        self.view?.removeTodoItem(at: index)
    }
    
    func onTodoDone(todoId: String) {
        print("todo item done - id : \(todoId)")
    }
}

