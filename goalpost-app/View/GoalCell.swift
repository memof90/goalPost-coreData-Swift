//
//  GoalCell.swift
//  goalpost-app
//
//  Created by Memo Figueredo on 23/12/20.
//

import UIKit

class GoalCell: UITableViewCell {
    
//    MARK: IBOutlet

//   Goal decription Label
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    
//    type description label
    @IBOutlet weak var goalTypeLbl: UILabel!
    
    
    @IBOutlet weak var completionView: UIView!
    
//    number label
    @IBOutlet weak var goProgressLbl: UILabel!
    
    
    func configureCell(goal:Goal) {
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType
        self.goProgressLbl.text = String(describing: goal.goalProgress)
        
        if goal.goalProgress == goal.goalCompletionValue {
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
        }
    
    
//    func configureCell(description: String, type: GoalType, goalProgressAmount: Int) {
//        self.goalDescriptionLbl.text = description
//        self.goalTypeLbl.text = type.rawValue
//        self.goProgressLbl.text = String(describing: goalProgressAmount)
//    }
}
