//
//  ViewController.swift
//  Persons App (Draft Plan) MVVM
//
//  Created by Ahmet Erkut on 25.10.2023.
//

import UIKit
import RxSwift

class HomePage: UIViewController {

    @IBOutlet weak var personSearchBar: UISearchBar!
    @IBOutlet weak var personsTableView: UITableView!
    var personsList = [Persons]()
    
    let homePageVM = HomePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setData()
    }
    
    private func setUI() {
        personsTableView.delegate = self
        personsTableView.dataSource = self
        personSearchBar.delegate = self
    }
    
    private func setData() {
        _ = homePageVM.personsList.subscribe(onNext: { list in
            self.personsList = list
            DispatchQueue.main.async {
                self.personsTableView.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let data = sender as? Persons {
                let toVC = segue.destination as! PersonDetail
                toVC.person = data
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homePageVM.uploadPersons()
    }
}

extension HomePage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = personsList[indexPath.row]
        
        let cell = personsTableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonCell
        
        cell.personNameLabel.text = person.person_name
        cell.personPhoneLabel.text = person.person_phone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let person = personsList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: person)
        personsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, bool in
            let person = self.personsList[indexPath.row]
            
            let alert = UIAlertController(title: "Deletion", message: "Are you sure delete \n(\(person.person_name!))", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
            
            let okayAction = UIAlertAction(title: "Okay", style: .destructive) { action in
                self.homePageVM.delete(person_id: person.person_id!)
            }
            alert.addAction(okayAction)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension HomePage: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            homePageVM.uploadPersons()
        } else {
            homePageVM.search(searchText: searchText)
        }
    }
}
