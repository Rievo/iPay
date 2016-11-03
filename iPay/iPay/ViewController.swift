//
//  ViewController.swift
//  iPay
//
//  Created by Diego on 3/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    
    


    @IBOutlet var table: UITableView!
    
    
    let dele = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        table.dataSource = self
        table.delegate = self
        
        //TODO: Load transactions from file
        
        
        let nc = NotificationCenter.default // Note that default is now a property, not a method call
        nc.addObserver(forName:Notification.Name(rawValue:"reloadTable"),
                       object:nil, queue:nil) {
                        notification in
                        // Handle notification
                        self.table.reloadData()
        }
        
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        let transaction:Transaction = dele.transactions[indexPath.row]
        
        cell.textLabel?.text = transaction.description + " € : \(transaction.text!)"
        
        if(transaction.kind == .Sum){
            cell.backgroundColor = UIColor.green
        }else if(transaction.kind == .Substraction){
            cell.backgroundColor = UIColor.red
        }
        
    
        
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dele.transactions.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    
}

