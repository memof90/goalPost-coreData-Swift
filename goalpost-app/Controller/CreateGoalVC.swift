//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Memo Figueredo on 23/12/20.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {
    
//    MARK: IBOultet
    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var goalType: GoalType = .shortTerm

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        key board expanded
        nextBtn.bindToKeyboard()
//        button selected
        shortTermBtn.setSelectedColor()
//        button onselected
        longTermBtn.setDeselectedColor()
//        Delegate
        goalTextView.delegate = self
        
    }
    
//    MARK: Function
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalTextView.text = ""
        goalTextView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
//    MARK: IBAction
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedColor()
    }
    
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
    }
    
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text !=  "What is your goal?" {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "FinishGoalVC") as? FinishGoalVC else {
                return
            }
            finishGoalVC.initData(description: goalTextView.text!, type: goalType)
//            presentDetail(finishGoalVC)
//            present first view after of save data
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }


}
