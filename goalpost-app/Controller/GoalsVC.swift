//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Memo Figueredo on 22/12/20.
//

import UIKit
import CoreData

class GoalsVC: UIViewController {
    
//    MARK: IBOutlet
//    tableView
    @IBOutlet weak var tableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        MARK: tableview
//        tableView Configuration
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
    }

    //    MARK: IBAction
//    button addgoals
    @IBAction func addGoAlbtnWasPressed(_ sender: Any) {
    }
    
}

extension GoalsVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {
            return UITableViewCell()
        }
        cell.configureCell(description: "Eat salad twice a week.", type: .shortTerm, goalProgressAmount: 2)
        return cell
    }
    
    
}
