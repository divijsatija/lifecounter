//
//  HistoryViewController.swift
//  Life Counter 2.00
//
//  Created by Divij Satija on 5/3/21.
//

import UIKit

class HistoryViewController: UIViewController {
    

    
    @IBOutlet weak var historyLabel: UITextView!
    
    public var historyData: String! = nil

        override func viewDidLoad() {
            super.viewDidLoad()
            if historyData != nil {
//                self.historyLabel.numberOfLines = 0
                self.historyLabel.text = historyData
            }
        }
}
