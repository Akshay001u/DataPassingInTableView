//
//  SecondViewController.swift
//  DataPassingInTableView
//
//  Created by Akshay on 06/08/22.
//

import UIKit

class SecondViewController: ViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var rollNoTextField: UITextField!
    
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var phoneNoTextField: UITextField!
    
    var delegateSVC : StudentDataPassingProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    @IBAction func saveDataButton(_ sender: Any) {
        guard let delegate = delegateSVC else {
            return
        }
        
        
      // Alert Controller Used for No data condition
        if self.nameTextField.text! .isEmpty || self.rollNoTextField.text! .isEmpty || self.cityTextField.text! .isEmpty || self.phoneNoTextField.text! .isEmpty{
            
            let alertController = UIAlertController(title: "", message: "Please Enter All Details", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                }

            alertController.addAction(okAction)

                // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
        
        
        
        // Alert Condition for Data Filled Condition
        else{
            let studentNameToPass = self.nameTextField.text ?? ""
            let studentRollNoToPass = self.rollNoTextField.text ?? ""
            let studentCityToPass = self.cityTextField.text ?? ""
            let studentPhoneNoToPass = self.phoneNoTextField.text ?? ""
            
            let studentObjectToPass = Student(studentName: studentNameToPass, rollNo: Int(studentRollNoToPass) ?? 0, city: studentCityToPass, phoneNo: studentPhoneNoToPass)
          
            delegate.passStudentData(student: studentObjectToPass)
            
            
        let alertController = UIAlertController(title: "", message: "Data saved Successfully", preferredStyle: .alert)

            // Create the actions
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("Ok Pressed")
        self.navigationController?.popViewController(animated: true)
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
            }

            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)

            // Present the controller
        self.present(alertController, animated: true, completion: nil)
    
        }
        
    }
}
