//
//  DetailVC.swift
//  Todo
//
//  Created by Andy Ron on 2018/8/5.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    var todo: TodoItem?
    
    @IBOutlet weak var childButton: UIButton!    
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shoppingCartButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoDatePicker: UIDatePicker!
    @IBOutlet weak var todoTitleTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let todo = todo {
            self.title = "Edit Todo"
            if todo.image == "child-selected" {
                childButton.isSelected = true
                childButton.imageView?.image = UIImage(named: todo.image)
            } else if todo.image == "phone-selected" {
                phoneButton.isSelected = true
            } else if todo.image == "shopping-cart-selected" {
                shoppingCartButton.isSelected = true
            } else if todo.image == "travel-selected" {
                travelButton.isSelected = true
            }
            todoTitleTF.text = todo.title
            todoDatePicker.setDate(todo.date, animated: false)
        } else {
            title = "New Todo"
            childButton.isSelected = true
        }

    }
    
    @IBAction func selectChild(_ sender: Any) {
        resetButtons()
        childButton.isSelected = true
    }
    
    @IBAction func selectPhone(_ sender: Any) {
        resetButtons()
        phoneButton.isSelected = true
    }
    
    @IBAction func selectShoppingCart(_ sender: Any) {
        resetButtons()
        shoppingCartButton.isSelected = true
    }
    
    @IBAction func selectTravel(_ sender: Any) {
        resetButtons()
        travelButton.isSelected = true
    }
    
    @IBAction func done(_ sender: Any) {
        var image = ""
        if childButton.isSelected {
            image = "child-selected"
        }
        else if phoneButton.isSelected {
            image = "phone-selected"
        }
        else if shoppingCartButton.isSelected {
            image = "shopping-cart-selected"
        }
        else if travelButton.isSelected {
            image = "travel-selected"
        }
        
        if let todo = todo {
            todo.image = image
            todo.title = todoTitleTF.text!
            todo.date = todoDatePicker.date
        } else {
            let uuid = UUID().uuidString
            todo = TodoItem(id: uuid, image: image, title: todoTitleTF.text!, date: todoDatePicker.date)
            todos.append(todo!)
        }
        
        let _ = navigationController?.popToRootViewController(animated: true)
    }
    
    func resetButtons() {
        childButton.isSelected = false
        phoneButton.isSelected = false
        shoppingCartButton.isSelected = false
        travelButton.isSelected = false
    }
    
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

}
