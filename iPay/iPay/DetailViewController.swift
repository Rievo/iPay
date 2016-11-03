//
//  DetailViewController.swift
//  iPay
//
//  Created by Diego on 3/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    let dele = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var textfield: UITextField!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var addButton: UIButton!
    
    var selectedType: TransactionType?
    
    
    @IBOutlet var ammountTextField: UITextField!
   
    
    @IBOutlet var finish: UIButton!
    
    @IBAction func setAddType(_ sender: Any) {
        selectedType = TransactionType.Sum
        minusButton.alpha = 0.5
        addButton.alpha = 1.0
    }
    
    @IBAction func setMinusType(_ sender: Any) {
       
        selectedType = TransactionType.Substraction
        addButton.alpha = 0.5
        minusButton.alpha = 1.0
    }
    
    @IBAction func finish(_ sender: Any) {
       
        if((selectedType) != nil){
            let trans = createTransaction()
            
            dele.transactions.append(trans)
            
            
            let nc = NotificationCenter.default
            nc.post(name:Notification.Name(rawValue:"reloadTable"),
                    object: nil,
                    userInfo: nil)
            
           _ =  self.navigationController?.popToRootViewController(animated: true)
            
    
        }else{
            print("Select a type")
        }
        
    }
    
    func setDefaultSubstraction() -> Void {
        selectedType = TransactionType.Substraction
        addButton.alpha = 0.5
        minusButton.alpha = 1.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //Default substraction
        setDefaultSubstraction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTransaction() -> Transaction {
        let new:Transaction = Transaction()
        
        let floatValue : Float = NSString(string: ammountTextField.text!).floatValue
        
        new.ammount = floatValue
        new.text = textfield.text as NSString?
        new.kind = selectedType!
        
        
        new.date = datePicker.date
        
        return new
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textfield.endEditing(true)
        ammountTextField.endEditing(true)
    }
    

}
