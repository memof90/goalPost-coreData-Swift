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
    
//    number label
    @IBOutlet weak var goProgressLbl: UILabel!
    
    
    func configureCell(description: String, type: String, goalProgressAmount: Int) {
        self.goalDescriptionLbl.text = description
        self.goalTypeLbl.text = type
        self.goProgressLbl.text = String(describing: goalProgressAmount)
    }
}
