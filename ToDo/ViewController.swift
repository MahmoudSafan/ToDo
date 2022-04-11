//
//  ViewController.swift
//  ToDo
//
//  Created by Mahmoud Safan on 08/04/2022.
//

import UIKit

var tasks:[String] = []

class ViewController: UIViewController {
    
    @IBOutlet weak var tasksTableView: UITableView!
    
    @IBAction func addButtonSelected(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "Entry") as! EntryViewController
        vc.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        vc.title = "New Task"
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        
        tasksTableView.dataSource = self
        tasksTableView.delegate = self
        
        /// UserDefaults Setup
        
        if !UserDefaults().bool(forKey: "setup"){
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        updateTasks()
        
    }
    
    func updateTasks(){
        // to don't duplicate tasks
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        
        for i in 0..<count{
            if let task = UserDefaults().value(forKey: "task_\(i+1)") as? String{
                tasks.append(task)
            }
        }
        
        tasksTableView.reloadData()
    }
    
    
    func deleteTaskRef(_ taskIndex:Int){
        UserDefaults().removeObject(forKey: "task_\(taskIndex)")
        tasks.remove(at: taskIndex)
        tasksTableView.reloadData()
        print("task \(taskIndex) deleted succssefuly")
    }

}






extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell{
            cell.textLabel?.text = tasks[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "Task") as! TaskViewController
        vc.title = "Task"
        vc.task = tasks[indexPath.row]
        vc.taskPath = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    
    }
}


extension ViewController{
    func go_screen(_ id:String, _ name:String){
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(identifier: id)
        vc.title = name
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
