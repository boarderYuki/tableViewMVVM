//
//  TodoItemTableViewCell.swift
//  tableViewMVVM
//
//  Created by yuki.pro on 2018. 6. 15..
//  Copyright © 2018년 yuki. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {

    @IBOutlet weak var txtIndex: UILabel!
    @IBOutlet weak var txtTodoItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /**
     * 뷰모델 이용해서 셀을 사용하게 설정
     * @param viewModel
     * @returns Void
     */
    func configure(withViewModel viewModel: TodoItemPresentable) -> (Void) {
        
        txtIndex.text = viewModel.id!
        txtTodoItem.text = viewModel.textValue!
    }
}
