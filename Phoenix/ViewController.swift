//
//  ViewController.swift
//  Phoenix
//
//  Created by Yu Chen on 7/2/17.
//  Copyright © 2017 Yu Chen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var textfield: UITextField!
    
    @IBOutlet var textLabel: UILabel!
    
    @IBAction func loginAction(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newValue.setValue(textfield.text, forKey: "first_name" )
        
        do{
            try context.save()
            textfield.alpha = 0
            loginButton.alpha = 0
            textLabel.alpha = 1
            textLabel.text = "Hi there, " + textfield.text! + "!"
            
        }catch{
            print("Was unable to save.")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject]{
                if let username = result.value(forKey:"first_name") as? String{
                    
                    textfield.alpha = 0
                    loginButton.alpha = 0
                    textLabel.alpha = 1
                    textLabel.text = "Hi there, " + username + "!"
                    
                }
            }
            
            
        } catch {
            
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
