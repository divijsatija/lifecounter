//
//  ViewController.swift
//  Life Counter
//
//  Created by Divij Satija on 4/25/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var life1: UILabel!
    @IBOutlet weak var life2: UILabel!
    @IBOutlet weak var life3: UILabel!
    @IBOutlet weak var life4: UILabel!
    @IBOutlet weak var loser: UILabel!
    
    func updateLife(val: Int, target: Int) {
        switch target {
        case 1:
            let lifeTotal = Int(self.life1.text!)!
            let newTotal = lifeTotal + val
            life1.text = String(newTotal)
            if (newTotal <= 0) {
                self.loser.text = ("Player 1 Loses!")
            }
        case 2:
            let lifeTotal = Int(self.life2.text!)!
            let newTotal = lifeTotal + val
            life2.text = String(newTotal)
            if (newTotal <= 0) {
                self.loser.text = ("Player 2 Loses!")
            }
        case 3:
            let lifeTotal = Int(self.life3.text!)!
            let newTotal = lifeTotal + val
            life3.text = String(newTotal)
            if (newTotal <= 0) {
                self.loser.text = ("Player 3 Loses!")
            }
        case 4:
            let lifeTotal = Int(self.life4.text!)!
            let newTotal = lifeTotal + val
            life4.text = String(newTotal)
            if (newTotal <= 0) {
                self.loser.text = ("Player 4 Loses!")
            }
        default:
            print("N/A")
        }
    }
    
    @IBAction func posFiveP1(_ sender: Any) {
        updateLife(val: 5, target: 1)
    }
    
    @IBAction func posFiveP2(_ sender: Any) {
        updateLife(val: 5, target: 2)
    }
    
    @IBAction func posFiveP3(_ sender: Any) {
        updateLife(val: 5, target: 3)
    }
    
    @IBAction func posFiveP4(_ sender: Any) {
        updateLife(val: 5, target: 4)
    }
    
    @IBAction func negFiveP1(_ sender: Any) {
        updateLife(val: -5, target: 1)
    }
    
    @IBAction func negFiveP2(_ sender: Any) {
        updateLife(val: -5, target: 2)
    }
    
    @IBAction func negFiveP3(_ sender: Any) {
        updateLife(val: -5, target: 3)
    }
    
    @IBAction func negFiveP4(_ sender: Any) {
        updateLife(val: -5, target: 4)
    }
    
    @IBAction func posP1(_ sender: Any) {
        updateLife(val: 1, target: 1)
    }
    
    @IBAction func posP2(_ sender: Any) {
        updateLife(val: 1, target: 2)
    }
    
    @IBAction func posP3(_ sender: Any) {
        updateLife(val: 1, target: 3)
    }
    
    @IBAction func posP4(_ sender: Any) {
        updateLife(val: 1, target: 4)
    }
    
    @IBAction func negP1(_ sender: Any) {
        updateLife(val: -1, target: 1)
    }
    
    @IBAction func negP2(_ sender: Any) {
        updateLife(val: -1, target: 2)
    }
    
    @IBAction func negP3(_ sender: Any) {
        updateLife(val: -1, target: 3)
    }
    
    @IBAction func negP4(_ sender: Any) {
        updateLife(val: -1, target: 4)
    }
}

