//
//  FileSelectionViewController.swift
//  iBox
//
//  Created by Alsey Coleman Miller on 11/1/14.
//  Copyright (c) 2014 ColemanCDA. All rights reserved.
//

import UIKit
import BochsKit

private let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first as NSURL

class FileSelectionViewController: UITableViewController {
    
    // MARK: - Private Properties
    
    private var files = [NSURL]()
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refresh(self)
    }
    
    // MARK: - Methods
    
    func selectedFile() -> NSURL? {
        
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow() {
            
            return self.files[selectedIndexPath.row]
        }
        
        return nil
    }
    
    // MARK: - Actions
    
    @IBAction func refresh(sender: AnyObject) {
        
        self.files = NSFileManager.defaultManager().contentsOfDirectoryAtURL(documentsURL, includingPropertiesForKeys: nil, options: .SkipsHiddenFiles | .SkipsPackageDescendants | .SkipsSubdirectoryDescendants, error: nil)! as [NSURL]
        
        self.tableView.reloadData()
    }
    
    @IBAction func createNewImage(sender: AnyObject) {
        
        // create alert controller
        let alertController = UIAlertController(title: NSLocalizedString("Create New HDD Image", comment: "Create New HDD Image Alert Controller Title"),
            message: NSLocalizedString("Specify the filename (without the extension)", comment: "Create New HDD Image Alert Controller Message"),
            preferredStyle: UIAlertControllerStyle.Alert)
        
        // add text field
        alertController.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            
            textField.text = "hddImage"
        }
        
        // set completion
        
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.files.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCellReusableIdentifier.FileNameCell.rawValue, forIndexPath: indexPath) as UITableViewCell
        
        // get model object
        let file = self.files[indexPath.row]
        
        // configure cell
        cell.textLabel.text = file.lastPathComponent
        
        return cell
    }
}

// MARK: - Private Enumerations

private enum TableViewCellReusableIdentifier: String {
    
    case FileNameCell = "FileNameCell"
}