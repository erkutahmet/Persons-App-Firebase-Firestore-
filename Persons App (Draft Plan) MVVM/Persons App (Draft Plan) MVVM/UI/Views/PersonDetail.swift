//
//  PersonDetail.swift
//  Persons App (Draft Plan) MVVM
//
//  Created by Ahmet Erkut on 25.10.2023.
//

import UIKit

class PersonDetail: UIViewController {

    @IBOutlet weak var personNameTextField: UITextField!
    @IBOutlet weak var personPhoneTextField: UITextField!
    
    var person:Persons?
    
    let personDetailVM = PersonDetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        if let p = person {
            personNameTextField.text = p.person_name
            personPhoneTextField.text = p.person_phone
        }
    }
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        if let personName = personNameTextField.text, let personPhone = personPhoneTextField.text, let p = person {
            let person_name = personName.replacingOccurrences(of: " ", with: "")
            let person_phone = personPhone.replacingOccurrences(of: " ", with: "")
            
            if person_name != String() && person_phone != String() {
                let pName = personName.trimmingCharacters(in: .whitespaces)
                let pPhone = personPhone.trimmingCharacters(in: .whitespaces)
                personDetailVM.update(person_id: p.person_id!,
                                      person_name: pName,
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
