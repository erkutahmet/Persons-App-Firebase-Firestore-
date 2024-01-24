//
//  HomePageViewModel.swift
//  Persons App (Draft Plan) MVVM
//
//  Created by Ahmet Erkut on 25.10.2023.
//

import Foundation
import RxSwift

class HomePageViewModel {
    let pRepo = PersonsDaoRepository()
    var personsList = BehaviorSubject<[Persons]>(value: [Persons]())
    
    init() {
        pRepo.personsList = self.personsList
        uploadPersons()
    }
    
    func delete(person_id: String) {
        pRepo.delete(person_id: person_id)
    }
    
    func search(searchText: String) {
        pRepo.search(searchText: searchText)
    }
    
    func uploadPersons() {
        pRepo.uploadPersons()
    }
}
