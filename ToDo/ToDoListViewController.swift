//
//  ToDoListViewController.swift
//  ToDo
//
//  Created by Thomas Röthemeyer on 27/12/2015.
//  Copyright © 2015 Thomas Röthemeyer. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController, UITableViewDataSource, AddItemViewControllerProtocol {
    let cacheKey = "CacheKey"
    let cellIdentifier = "CellIdentifier"

    @IBOutlet weak var tableView: UITableView?
    
    var items = NSMutableArray ()
    var cache: CacheProtocol = KeyedArchiverCache()   // UserDefaultsCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Do any additional setup after loading the view.
        
        // Load persisted data if any exists
        self.load()
        
        self.title = "ToDo List"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "didTapAdd:")
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        self.tableView?.dataSource = self
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    // MARK: AddItemViewControllerProtoclol
    
    func addItem(item: String) {
        
        // Add the new item to our items array
        
        self.items.insertObject(item, atIndex: 0)
        
        // Modify the tableview / listview to display this new item
        
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView?.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
    
        // Save the current data set to disk
        self.save()    
    }

    // MARK: UITAbleViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier)!
        
        let item = self.items[indexPath.row] as! String
        
        cell.textLabel?.text = item
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            self.items.removeObjectAtIndex(indexPath.row)
            self.tableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Left)
       
            // Save the current data set to disk
            self.save()
        }
    }
    
    // MARK: Actions
    
    func didTapAdd(sender: UIBarButtonItem) {
    
        let viewController = AddItemViewController()
        viewController.delegate = self
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.view.backgroundColor = UIColor.whiteColor()
        
        self.presentViewController(navigationController, animated: true, completion: nil)
    }

     override func setEditing(editing: Bool, animated: Bool) {
    
        super.setEditing(editing, animated: animated)
        
        self.tableView?.setEditing(editing, animated: animated)
        
        self.navigationItem.rightBarButtonItem?.enabled = !editing
    }

    // MARK: Cache Actions
    
    func load() {
        
        let object = self.cache.loadObjectForKey("CacheKey")
        
        if let items = object as? NSArray {
        
            self.items = NSMutableArray(array: items)
            
        }
        
    }
    
    func save() {
        
        self.cache.saveObject(self.items, key: "CacheKey")
    }
}
