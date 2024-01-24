//
//  PersonRegisterViewModel.swift
//  Persons App (Draft Plan) MVVM
//
//  Created by Ahmet Erkut on 25.10.2023.
//

import Foundation

class PersonRegisterViewModel {
    let pRepo = PersonsDaoRepository()
    
    func save(person_name: String, person_phone: String) {
        pRepo.save(person_name: person_name, person_phone: person_phone)
    }
}
