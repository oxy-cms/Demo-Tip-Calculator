//
//  TipCalculatorVC.swift
//  DemoCalculator
//
//  Created by Stephanie Angulo on 11/1/16.
//  Copyright © 2016 Stephanie Angulo. All rights reserved.
//

import UIKit

class TipCalculatorVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var percentTextField: UITextField!
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!

    
    let defaultPercent = "30"
    var stringBill: String?
    var stringPercent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TipCalculatorVC.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        billTextField.delegate = self
        percentTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        billTextField.addTarget(self, action: #selector(TipCalculatorVC.textFieldDidBeginEditing(_:)), for: UIControlEvents.editingChanged)
        percentTextField.addTarget(self, action: #selector(TipCalculatorVC.textFieldDidBeginEditing(_:)), for: UIControlEvents.editingChanged)
        
        
        percentTextField.text = defaultPercent
        if (billTextField.text?.isEmpty)! {
            self.percentTextField.isHidden = true
            self.tipLabel.isHidden = true
            self.totalLabel.isHidden = true
            self.percentLabel.isHidden = true
            self.tableView.isHidden = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (billTextField.text?.isEmpty)! {
            print("Bill textfield is empty")
            self.percentTextField.isHidden = true
            self.tipLabel.isHidden = true
            self.totalLabel.isHidden = true
            self.percentLabel.isHidden = true
            self.tableView.isHidden = true
        } else if (percentTextField.text?.isEmpty)! {
            self.percentTextField.isHidden = false
            self.tipLabel.isHidden = false
            self.totalLabel.isHidden = false
            self.percentLabel.isHidden = false
            self.tableView.isHidden = false
            calculateTotal(inputtedBill: billTextField, inputtedPercent: percentTextField)
            self.tableView.reloadData()
        } else {
            print("Bill textfield is being edited")
            self.percentTextField.isHidden = false
            self.tipLabel.isHidden = false
            self.totalLabel.isHidden = false
            self.percentLabel.isHidden = false
            self.tableView.isHidden = false
            calculateTotal(inputtedBill: billTextField, inputtedPercent: percentTextField)
            self.tableView.reloadData()
        }
    }
    
    func calculateTotal(inputtedBill: UITextField, inputtedPercent: UITextField) -> Double {
        stringBill = inputtedBill.text!
        if !((inputtedPercent.text?.isEmpty)!) {
            stringPercent = inputtedPercent.text!
        } else {
            stringPercent = "0"
        }
        let bill = Double(stringBill!) ?? 0
        let percent = Double(stringPercent!)!/100
        let tip = bill*percent
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        print("Total is: " + String(total))
        return total
    }
    func splitBill(split: IndexPath) -> Double {
        let constant = 25
        var x = 33
        let y = 27
        let amountOfPeople = Double(split.row + 2)
       
        let peopleIconImageView = UIImageView(image:UIImage(named: "peopleicon.png"))
        
        peopleIconImageView.contentMode = UIViewContentMode.scaleAspectFit
        peopleIconImageView.frame.size.width = CGFloat(constant)
        peopleIconImageView.frame.size.height = CGFloat(constant)
   
//        for i in 2...6 {
//            peopleIconImageView.frame = CGRect(x: x+1, y: y, width: constant, height: constant)
//            //cell.contentView.addSubview(peopleIconImageView)
//            x+=25
//        }
        
//        repeat {
//        counter++

//
//        } while (amountOfPeople)
        
        let newBill = calculateTotal(inputtedBill: billTextField, inputtedPercent: percentTextField)/amountOfPeople
        print("Bill with split is: " + String(newBill))
        return newBill
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let constant = 25
        var x = 33
        let y = 27
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SplitCell", for: indexPath) as! SplitCell
        
        
        cell.splitAmountLabel.text = String(format: "$%.2f", splitBill(split: indexPath))
       
        for i in 0...indexPath.row {
            let peopleIconImageView = UIImageView(image:UIImage(named: "peopleicon.png"))
            peopleIconImageView.contentMode = UIViewContentMode.scaleAspectFit
            peopleIconImageView.frame.size.width = CGFloat(constant)
            peopleIconImageView.frame.size.height = CGFloat(constant)
            peopleIconImageView.frame = CGRect(x: x+1, y: y, width: constant, height: constant)
            cell.contentView.addSubview(peopleIconImageView)
            x+=25
        }
//        cell.peopleIconImageView3 =
//        let amountOfPeople = Double(split.row + 2)
//

//        

        
        //        for i in 2...6 {
        
        //            //
        //            x+=25
        //        }
        
        //        repeat {
        //        counter++
        
        //
        //        } while (amountOfPeople)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */


}
