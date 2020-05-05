//
//  ViewController.swift
//  ProfileView
//
//  Created by eduardo rodríguez on 04/05/2020.
//  Copyright © 2020 Eduardo Rodríguez Pérez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var headerView: PassthroughView!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var externalScrollView: UIScrollView!
    @IBOutlet weak var scrollView1: UIScrollView!
    @IBOutlet weak var scrollView1Width: NSLayoutConstraint!
    @IBOutlet weak var container1TopConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView2: UIScrollView!
    @IBOutlet weak var container2TopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        externalScrollView.delegate = self
        scrollView1.delegate = self
        scrollView2.delegate = self
        scrollView1Width.constant = self.view.frame.width
        
        container1TopConstraint.constant = headerView.frame.height
        container2TopConstraint.constant = headerView.frame.height
    }
    
    var changingIndex = false
    @IBAction func indexChanged(_ sender: Any) {
        changingIndex = true
        let x = segmentView.selectedSegmentIndex * Int(externalScrollView.frame.width)
        externalScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        changingIndex = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == externalScrollView {
            if !changingIndex{
                segmentView.selectedSegmentIndex = Int(round(externalScrollView.contentOffset.x / externalScrollView.frame.size.width))
            }
        } else {
            if scrollView.contentOffset.y >= headerView.frame.height - segmentView.frame.height {
                headerTopConstraint.constant = -headerView.frame.height + segmentView.frame.height
                if scrollView == scrollView1 && scrollView2.contentOffset.y < headerView.frame.height - segmentView.frame.height{
                    scrollView2.contentOffset.y = headerView.frame.height - segmentView.frame.height
                } else if scrollView == scrollView2 && scrollView1.contentOffset.y < headerView.frame.height - segmentView.frame.height {
                    scrollView1.contentOffset.y = headerView.frame.height - segmentView.frame.height
                }
            } else {
                headerTopConstraint.constant = -scrollView.contentOffset.y
                scrollView1.contentOffset.y = scrollView.contentOffset.y
                scrollView2.contentOffset.y = scrollView.contentOffset.y
            }
        }
    }
}

