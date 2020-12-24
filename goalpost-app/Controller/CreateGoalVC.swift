//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Memo Figueredo on 23/12/20.
//

import UIKit

class CreateGoalVC: UIViewController {
    
//    MARK: IBOultet
    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    MARK: IBAction
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        
    }
    
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
