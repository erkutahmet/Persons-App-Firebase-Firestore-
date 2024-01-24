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
        let updatedPerson:[String:Any] = ["person_name":person_name, "person_phone":person_phone]
        collectionPersons.document(person_id).updateData(updatedPerson)
    }
    
    func delete(person_id: String) {
        collectionPersons.document(person_id).delete()
    }
    
    func search(searchText: String) {
        collectionPersons.addSnapshotListener{ snapshot, error in
            var list = [Persons]()
            
            if let documents = snapshot?.documents {
                for document in documents {
                    let data = document.data()
                    let person_id = document.documentID
                    let person_name = data["person_name"] as? String ?? ""
                    let person_phone = data["person_phone"] as? String ?? ""
                    
                    if person_name.lowercased().contains(searchText.lowercased()) {
                        let person = Persons(person_id: person_id, person_name: person_name, person_phone: person_phone)
                        list.append(person)
                    }
                }
            }
            
            self.personsList.onNext(list)
        }
    }
    
    func uploadPersons() {
        collectionPersons.addSnapshotListener{ snapshot, error in
            var list = [Persons]()
            
            if let documents = snapshot?.documents {
                for document in documents {
                    let data = document.data()
                    let person_id = document.documentID
                    let person_name = data["person_name"] as? String ?? ""
                    let person_phone = data["person_phone"] as? String ?? ""
                    
                    let person = Persons(person_id: person_id, person_name: person_name, person_phone: person_phone)
                    list.append(person)
                }
            }
            
            self.personsList.onNext(list)
        }
    }
}
