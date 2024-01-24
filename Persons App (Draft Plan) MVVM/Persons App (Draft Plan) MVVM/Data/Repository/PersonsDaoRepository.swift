//
//  PersonsDaoRepository.swift
//  Persons App (Draft Plan) MVVM
//
//  Created by Ahmet Erkut on 25.10.2023.
//

import Foundation
import RxSwift
import FirebaseFirestore

class PersonsDaoRepository {
    var personsList = BehaviorSubject<[Persons]>(value: [Persons]())
    var collectionPersons = Firestore.firestore().collection("Persons")
    
    func save(person_name: String, person_phone: String) {
        let newPerson:[String:Any] = ["person_id":"", "person_name":person_name, "person_phone":person_phone]
        collectionPersons.document().setData(newPerson)
    }
    
    func update(person_id: String, person_name: String, person_phone: String) {
        print("Person Update: \(person_id) -> \(person_name), \(person_phone)")
    }
    
    func delete(person_id: String) {
        print("Person Delete: \(person_id)")
        uploadPersons()
    }
    
    func search(searchText: String) {
        print("Person Search: \(searchText)")
    }
    
    func uploadPersons() {
        var list = [Persons]()
        let p1 = Persons(person_id: "1", person_name: "Ahmet", person_phone: "1111")
        let p2 = Persons(person_id: "2", person_name: "Zeynep", person_phone: "2222")
        let p3 = Persons(person_id: "3", person_name: "Beyza", person_phone: "3333")
        list.append(p1)
        list.append(p2)
        list.append(p3)
        personsList.onNext(list)
    }
}
