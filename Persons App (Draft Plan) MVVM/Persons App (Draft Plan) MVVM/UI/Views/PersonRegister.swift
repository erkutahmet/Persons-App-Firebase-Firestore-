//
//  PersonRegister.swift
//  Persons App (Draft Plan) MVVM
//
//  Created by Ahmet Erkut on 25.10.2023.
//

import UIKit

class PersonRegister: UIViewController {
    
    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var personPhoneTextField: UITextField!
    
    let personRegisterVM = PersonRegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        if let personName = personNameTextField.text, let personPhone = personPhoneTextField.text {
            let person_name = personName.replacingOccurrences(of: " ", with: "")
            let person_phone = personPhone.replacingOccurrences(of: " ", with: "")
            
            if person_name != String() && person_phone != String() {
                let pName = personName.trimmingCharacters(in: .whitespaces)
                let pPhone = personPhone.trimmingCharacters(in: .whitespaces)
                personRegisterVM.save(person_name: pName,
                                      person_phone: pPhone)
                navigationController?.popToRootViewController(animated: true)
            } else {
                let alertController = UIAlertController(title: "Error", message: "Please check fields!", preferredStyle: .alert)
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0) {
                    alertController.dismiss(animated: true, completion: nil)
                }
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
