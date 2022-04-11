import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var taskField:UITextField!
    
    // referance for update function
    var update:(()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskField.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    
    
   @objc func saveTask(){
        
        guard let text = taskField.text , !text.isEmpty else{
            return
        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        let newCount = count + 1
       UserDefaults().set(newCount, forKey: "count")
       UserDefaults().set(text, forKey: "task_\(newCount)")
        
        update?()
        
        navigationController?.popViewController(animated: true)

        
        print("Task Saved Successfuly .... \(taskField.text!)")
    }
    

}
