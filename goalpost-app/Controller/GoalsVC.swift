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
    
    
    @IBOutlet weak var undoBtnView: UIView!
    
    
//    devuelve una matriz de los resultados de la solicitud
//    establecer esto para buscar y analizar en la matriz
    var goals: [Goal] = []
    var goalRemove: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        MARK: tableview
//        tableView Configuration
        tableView.isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
      
        undoBtnView.isHidden = true
        
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
    
    @IBAction func undoBtnWassPressed(_ sender: Any) {
        goalRemove = false
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
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
//            self.removeGoal(atIndexPath: indexPath)
//            self.fetchCoreDataObjects()
//
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//
//        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
//            self.setProgress(atIndexPath: indexPath)
//            tableView.reloadRows(at: [indexPath], with: .automatic)
//        }
//        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
//        addAction.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
//        return [deleteAction, addAction]
//    }
//
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { (rowAction, view, completion: (Bool) -> Void) in
            
            self.undoBtnView.isHidden  = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                if goalRemove {
                    self.removeGoal(atIndexPath: indexPath)
                    self.fetchCoreDataObjects()
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                } else {
                    goalRemove = true
                    tableView.reloadData()
                }
                self.undoBtnView.isHidden = true
            }
            
//            self.removeGoal(atIndexPath: indexPath)
//            completion(true)
//            self.fetchCoreDataObjects()
//            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        let addAction = UIContextualAction(style: .normal, title: "ADD 1") { (rowAction, view, completion: (Bool) -> Void) in
            self.setProgress(atIndexPath: indexPath)
            completion(true)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            
        }
        addAction.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [deleteAction,addAction])
        swipeActionConfig.performsFirstActionWithFullSwipe = true
        
        return swipeActionConfig
    }
    
}

extension GoalsVC {
    
    func setProgress(atIndexPath indexPath: IndexPath){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        let chosenGoal = goals[indexPath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Sucessfully set progress!")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
    
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
