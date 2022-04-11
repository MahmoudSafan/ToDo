//
//  TaskViewController.swift
//  ToDo
//
//  Created by Mahmoud Safan on 08/04/2022.
//

import UIKit


class TaskViewController: UIViewController {

    @IBOutlet weak var taskTitle:UILabel!
    
    var deleteTaskRef:(()->Void)?

    var task:String?
    var taskPath:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))

        taskTitle.text = task
    }

}
