//
//  Tab3TabViewController.swift
//  ProfileView
//
//  Created by eduardo rodríguez on 07/05/2020.
//  Copyright © 2020 Eduardo Rodríguez Pérez. All rights reserved.
//

import UIKit

class Tab3ViewController: UIViewController {
    
    @IBOutlet weak var tableView: MyOwnTableView!
    let data = Array(0...100)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}

extension Tab3ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell3") as! TableViewCell
        cell.label.text = "\(data[indexPath.row])"
        return cell
    }
}

