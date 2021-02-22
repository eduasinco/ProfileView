//
//  ViewController.swift
//  ProfileView
//
//  Created by eduardo rodríguez on 04/05/2020.
//  Copyright © 2020 Eduardo Rodríguez Pérez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var headerView: PassthroughView!
	@IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var headerHeighConstraint: NSLayoutConstraint!
	@IBOutlet weak var segmentView: UISegmentedControl!
	
	@IBOutlet weak var externalScrollView: UIScrollView!
	@IBOutlet weak var scrollView1: UIScrollView!
	@IBOutlet weak var scrollView1Width: NSLayoutConstraint!
	@IBOutlet weak var container1TopConstraint: NSLayoutConstraint!
	@IBOutlet weak var scrollView2: UIScrollView!
	@IBOutlet weak var container2TopConstraint: NSLayoutConstraint!
	@IBOutlet weak var scrollView3: UIScrollView!
	@IBOutlet weak var container3TopConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		externalScrollView.delegate = self
		scrollView1.delegate = self
		scrollView2.delegate = self
		scrollView3.delegate = self
		scrollView1Width.constant = self.view.frame.width
		container1TopConstraint.constant = headerView.frame.height
		container2TopConstraint.constant = headerView.frame.height
		container3TopConstraint.constant = headerView.frame.height
		segmentView.isExclusiveTouch = true
		
		setupRefreshController()
	}
	
	private func setupRefreshController() {
		// Add the refresh control to your UIScrollView object.
		[scrollView1,
		scrollView2,
		scrollView3].forEach { (view) in
			view?.refreshControl = UIRefreshControl()
			view?.refreshControl?.addTarget(self, action:
																										#selector(handleRefreshControl),
																									 for: .valueChanged)
		}
	}
	
	@objc func handleRefreshControl() {
		print("pullingggggg")
		view.isUserInteractionEnabled = false
		// Update your content…
		
		// Dismiss the refresh control.
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			[self.scrollView1,
			 self.scrollView2,
			 self.scrollView3].forEach { (view) in
				view?.refreshControl?.endRefreshing()
			}
			self.externalScrollView.refreshControl?.endRefreshing()
			self.view.isUserInteractionEnabled = true
		}
	}
	
	var changingIndex = false
	@IBAction func indexChanged(_ sender: Any) {
		changingIndex = true
		let x = segmentView.selectedSegmentIndex * Int(externalScrollView.frame.width)
		externalScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
	}
}

extension ViewController: UIScrollViewDelegate {
	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		changingIndex = false
	}
	
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		print(scrollView.tag)
		if scrollView == externalScrollView {
			if !changingIndex {
				segmentView.selectedSegmentIndex = Int(round(externalScrollView.contentOffset.x / externalScrollView.frame.size.width))
			}
		} else {
			let d = headerView.frame.height - segmentView.frame.height
			if scrollView.contentOffset.y >= d {
				headerTopConstraint.constant = -d
				if scrollView == scrollView1 && scrollView2.contentOffset.y < d && scrollView3.contentOffset.y < d {
					scrollView2.contentOffset.y = d
					scrollView3.contentOffset.y = d
				} else if scrollView == scrollView2 && scrollView1.contentOffset.y < d && scrollView3.contentOffset.y < d {
					scrollView1.contentOffset.y = d
					scrollView3.contentOffset.y = d
				} else if scrollView == scrollView3 && scrollView1.contentOffset.y < d && scrollView2.contentOffset.y < d {
					scrollView1.contentOffset.y = d
					scrollView2.contentOffset.y = d
				}
			} else {
				scrollView1.contentOffset.y = scrollView.contentOffset.y
				scrollView2.contentOffset.y = scrollView.contentOffset.y
				scrollView3.contentOffset.y = scrollView.contentOffset.y
			}
		}
		headerTopConstraint.constant = -scrollView.contentOffset.y
	}
}
