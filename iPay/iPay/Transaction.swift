//
//  Transaction.swift
//  iPay
//
//  Created by Diego on 3/11/16.
//  Copyright © 2016 Diego. All rights reserved.
//

import UIKit


enum TransactionType {
    case Sum
    case Substraction
}

class Transaction: NSObject {

    var ammount:Float
    var date:Date
    var text:NSString?
    var kind:TransactionType
    
    override init() {
        ammount = 0.0
        date = Date()
        kind = TransactionType.Sum
    }
    
    override var description: String{
        var str:String = ""
        
        if(kind == .Sum){
            str = str + "+ "
        }else{
            str = str + "- "
        }
        
        str = str + ammount.description
        
        return str
    }
    
    init(text:String){
        
        let strArray:[String] = text.components(separatedBy: "*")
        
        
        //if(strArray.count > 3){
            //Transaction type
            let kindStr = strArray[0]
            if(kindStr == "Substraction"){
                self.kind = .Substraction
            }else if(kindStr == "Sum"){
                self.kind = .Sum
            }else{
                self.kind = .Sum
            }
            
            //Annount
            let strAmmount = strArray[1]
            self.ammount = (strAmmount as NSString).floatValue
            
            //Date
            let strDate = strArray[2]
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            self.date = formatter.date(from: strDate)!
            
            //Text
            let strText = strArray[3]
            self.text = strText as NSString
        //}else{
            
        //}
        
        
        
        
        
    }
}
