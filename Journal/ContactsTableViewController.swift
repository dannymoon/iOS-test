//
//  JournalTableViewController.swift
//  Journal
//
//  Created by Danny Moon on 11/16/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit
import CoreData

class ContactsTableViewController: UITableViewController {

    
    @IBOutlet var contactsTableView: UITableView!
    var contacts: [Contacts] = []
    var managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let delegate = (UIApplication.shared.delegate as! AppDelegate)

    override func tableView(_ contactsTableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .actionSheet)


        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive)
        {
            _ in
            let item = self.contacts[indexPath.row]
            self.managedObjectContext.delete(item)
            do {
                try self.managedObjectContext.save()
            } catch {
                print("\(error)")
            }
            self.contacts.remove(at: indexPath.row)
            self.contactsTableView.reloadData()
        }
        let viewAction = UIAlertAction(title: "View", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "ShowItemSegue", sender: indexPath)
        } )

        let editAction = UIAlertAction(title: "Edit", style: .default, handler: { (action) -> Void in
            self.performSegue(withIdentifier: "AddItemSegue", sender: indexPath)
        } )


        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(viewAction)
        alert.addAction(editAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddItemSegue", sender: nil)
    }
    func saveContactsEntries() {
        do {
            try managedObjectContext.save()
            print("Successfully saved")
        } catch {
            print("Error when saving: \(error)")
        }
        fetchContactsEntries()
    }
    func fetchContactsEntries() {
        do {
            contacts = try managedObjectContext.fetch(Contacts.fetchRequest())
            print("Success")
        } catch {
            print("Error: \(error)")
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContactsEntries()
        do {
            let contacts = try managedObjectContext.fetch(Contacts.fetchRequest())
        } catch {
            print("Error: \(error)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case "AddItemSegue":
            let navigationController = segue.destination as! UINavigationController
            let addItemVC = navigationController.topViewController as! AddItemVC
            addItemVC.delegate = self as? AddItemDelegate
            if let ind = sender as? IndexPath {
                // edit
                let item = contacts[ind.row]
                addItemVC.firstname = item.first!
                addItemVC.lastname = item.last!
                addItemVC.number = item.number!
                addItemVC.indexPath = ind
                addItemVC.title = "Edit Contact"
            }
            else {
                // add
                addItemVC.title = "Add Contact"
            }
        case "ShowItemSegue":
            let navigationController = segue.destination as! UINavigationController
            let showItemVC = navigationController.topViewController as! ShowItemVC
            let ind = sender as! IndexPath
            let item = contacts[ind.row]
            showItemVC.name = item.first! + " " + item.last!
            showItemVC.number = item.number!
            showItemVC.title = item.first
        default:
            print("failed")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let contactsItem = contacts[indexPath.row]
        cell.textLabel!.text = contactsItem.first! + " " + contactsItem.last!
        cell.detailTextLabel!.text = contactsItem.number
        return cell
    }

}


extension ContactsTableViewController: AddItemDelegate {
    func addItem(_ firstname: String, _ lastname: String, _ number: String, sender: UIViewController, indexPath:IndexPath?) {
        
        if let ind = indexPath {
            let item = contacts[ind.row]
            item.first = firstname
            item.last = lastname
            item.number = number
            
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "Contacts", into: managedObjectContext) as! Contacts
            item.first = firstname
            item.last = lastname
            item.number = number
            
            
            contacts.append(item)
            print(contacts)
        }
        
        delegate.saveContext()
        contactsTableView.reloadData()
        sender.dismiss(animated: true, completion: nil)
    }
    
    
}
