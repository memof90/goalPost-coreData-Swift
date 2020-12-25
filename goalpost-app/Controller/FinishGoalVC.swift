//
//  FinishGoalVC.swift
//  goalpost-app
//
//  Created by Memo Figueredo on 25/12/20.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {
    
//    MARK: IBOutlet
    @IBOutlet weak var createGoalBtn: UIButton!
    
    @IBOutlet weak var pointsTextField: UITextField!
    
    
    var goalDescription: String!
    var goalType: GoalType!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        add keyboard fuction
        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self
    }
    
//    MARK: Fuctions
    func initData(description: String, type: GoalType) {
        self.goalDescription = description
        self.goalType = type
    }
// MARK: Fuctions Core Data sav,Delete,edit
    func save(completion: (_ finished: Bool) -> ()) {
//        obtain object context
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(pointsTextField.text!)!
        goal.goalProgress = Int32(0)
        
// save dqta if not can't  save  debug error
        
        do {
            try managedContext.save()
            print("Sucessfully saved data.")
//            say controller that finish save data
            completion(true)
        } catch {
            debugPrint("Could not save: \(error)")
            completion(false)
        }
        
    }
    
    //    MARK: IBAction
    @IBAction  func createGoalBtnWasPressed(_ sender: Any) {
        
//        check that user wrote to textview
        if pointsTextField.text != "" {
//        pass data into Core Data Goal Model
        self.save { (complete) in
        if complete {
                dismiss(animated: true, completion: nil)
               }
            }
        }
    
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    

}

