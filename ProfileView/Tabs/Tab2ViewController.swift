//
//  Tab2ViewController.swift
//  ProfileView
//
//  Created by eduardo rodríguez on 05/05/2020.
//  Copyright © 2020 Eduardo Rodríguez Pérez. All rights reserved.
//

import UIKit

class Tab2ViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	let data = Array(0...100)
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.translatesAutoresizingMaskIntoConstraints = false
		tableView.delegate = self
		tableView.dataSource = self
		// Do any additional setup after loading the view.
	}
}

extension Tab2ViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell2") as! TableViewCell
		cell.label.text = "\(data[indexPath.row])"
		return cell
	}
}

