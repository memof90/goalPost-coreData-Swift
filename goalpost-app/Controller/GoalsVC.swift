//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Memo Figueredo on 22/12/20.
//

import UIKit
import CoreData

// access to delegate into all controller
let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
    
//    MARK: IBOutlet
//    tableView
    @IBOutlet weak var tableView: UITableView!
    
//    devuelve una matriz de los resultados de la solicitud
//    establecer esto para buscar y analizar en la matriz
    var goals: [Goal] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        MARK: tableview
//        tableView Configuration
        tableView.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
      
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tableView.reloadData()
          
               
    }
    
//    MARK: Function
//    funtion to reload table View
    func fetchCoreDataObjects(){
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tableView.isHidden = false
                    
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }

    //    MARK: IBAction
//    button addgoals
    @IBAction func addGoAlbtnWasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {
            return
        }
        
        presentDetail(createGoalVC)
    }
    
}

extension GoalsVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        put all items in tableView
        let goal = goals[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else {
            return UITableViewCell()
        }
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
//    mehtod depreciated
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [deleteAction]
    }
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { (<#UIContextualAction#>, <#UIView#>, <#@escaping (Bool) -> Void#>) in
//            <#code#>
//        }
//    }
    
}

extension GoalsVC {
//    remove item of table
    func removeGoal(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        managedContext.delete(goals[indexPath.row])
        
        do {
            try managedContext.save()
            print("Sucessfully remove goal!")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    func fetch(completion: (_ complete: Bool) -> ()){
//        obtain data to  manage object
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
//        let fetchRequest : NSFetchRequest<Goal> = Goal.fetchRequest()
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do {
        goals = try managedContext.fetch(fetchRequest)
        print("Successfully Fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
        completion(false)
        }
    }
}
