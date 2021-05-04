//
//  ViewController.swift
//  NibLoadingDemo
//
//  Goal: When the user pushes the "Add Person" button at the top of this
//  screen, a "name/age" (and "Happy Birthday!" button) should appear in
//  a vertically-growing list. The Person "panel" should be loaded from a
//  XIB file, and when the "Happy Birthday!" button is pressed, it should
//  increment the Person's age, and the hosting ViewController (this one)
//  should present an Alert controller that says "Happy Birthday!"
//
//  Created by Ted Neward on 4/27/21.
//

import UIKit

var history: [String] = []
//var losers: [Int] = []
//var loserSize = 0
var disableAdd = false

class ViewController: UIViewController {
    @IBOutlet weak var contentView: UIStackView!
    
    var count = 1
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        contentView.axis = .vertical
        contentView.spacing = 16
        super.viewDidLoad()
        count = 1
        while count <= 4 {
            addPlayerToView()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let historyVC = segue.destination as? HistoryViewController {
                var data = ""
                for i in history {
                    data.append(i + "\n")
                }
                print(data)
                historyVC.historyData = data
            }
    }
    
    @IBAction func addPerson(_ sender: Any) {
        
        if disableAdd {
            let myController = UIAlertController(title: "Sorry!", message: "Cannot add more players; Game already started", preferredStyle: .alert)
            myController.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Let's play!"), style: .default, handler: {
                _ in NSLog("okay")
            }))
            present(myController, animated: true, completion: {NSLog("okayy")})
        } else if count <= 8 {
            addPlayerToView()
        } else {
            let myController = UIAlertController(title: "Sorry!", message: "Cannot add more players", preferredStyle: .alert)
            myController.addAction(UIAlertAction(title: NSLocalizedString("Okay", comment: "Let's play!"), style: .default, handler: {
                _ in NSLog("okay")
            }))
            present(myController, animated: true, completion: {NSLog("okayy")})
        }
        /* Option 1: The Hard Way
           Add a PersonPanel to the vertical center "the hard way":
            - create the raw nib file (File | New | File... | under User Interface select View), add controls into it (horizontal stack view with two children, one label and one button
            - instantiate the nib here using loadNibNamed(:owner) with an owner of nil since we want to do all the "wiring" up ourselves
            - take the resulting view from the nib (which will be the horizontal stack view) and add it into the view hierarchy under the vertical stack view (self.contentView)
            - wire up the button to print an NSLog()
         */
        /*
        nameAgeArray.append((name, age))
        NSLog("array: \(nameAgeArray)")
        
        // Instantiate a PersonPanel from the XIB
        let nib = Bundle.main.loadNibNamed("PersonPanel", owner: nil)
        let nibView = (nib?.first) as! UIView // this is the UIStackView

        NSLog("nibView has \(nibView.subviews.count) subviews") // 1 -- the UIStackView
        NSLog("nibView.subviews[0].subviews has \(nibView.subviews[0].subviews.count) subviews") // 2 -- the label and the button

        let nibLabel = nibView.subviews[0].subviews[0] as! UILabel
        nibLabel.text = "\(name) : \(age)"
        
        // Wire up the nibButton to point to a function in this ViewController
        let nibButton = nibView.subviews[0].subviews[1] as! UIButton
        nibButton.tag = nameAgeArray.count - 1 // this is our index into the nameAgeArray
        nibButton.addTarget(self, action: #selector(happyBirthdayPushed(_:)), for: .touchUpInside)
        
        // Add the subview but use the "arranged" version so that it will be arranged according to the rules of a UIStackView
        contentView.addArrangedSubview(nibView)
        // */
        
        /* Option 2: Create a custom UIView subclass to handle its own events */
        
    }
    
    func addPlayerToView() {
        NSLog("Add Person")
        let life = 20
        
        let personPanel = PersonPanelView()
        personPanel.data = ("Player \(count)", life)
        contentView.addArrangedSubview(personPanel)
        count += 1
    }
    
//    func checkLoser() {
//        if loserSize < losers.count {
//            let myController = UIAlertController(title: history[count - 1], message: "The above player loses!", preferredStyle: .alert)
//            myController.addAction(UIAlertAction(title: NSLocalizedString("Continue", comment: "Let's play!"), style: .default, handler: {
//                _ in NSLog("okay")
//            }))
//            loserSize += 1
//        }
//        if loserSize == count {
//            // reset
//        }
//    }
    
    // Option 1 supporting code
    /*
    var nameAgeArray : [(String, Int)] = [] // This is an array of (String, Int) tuples
    @objc func happyBirthdayPushed(_ sender: UIButton) {
        // Go get the "tag" value associated with our button
        // Remember, that's our index into the nameAgeArray
        let index = sender.tag

        // Update the array with the new age; tuples are value types, so we need to extract the pair, update the age in it locally, then store that new value back into the array
        var nameAgePair = nameAgeArray[index]
        nameAgePair.1 = nameAgePair.1 + 1
        nameAgeArray[index] = nameAgePair

        // Go find our paired label by looking at the UIStackView's children and getting the first one; update it with the new ages
        let pairedLabel = sender.superview!.subviews[0] as! UILabel
        pairedLabel.text = "\(nameAgePair.0) : \(nameAgePair.1)"

        NSLog("Happy Birthday, \(nameAgePair.0) you are now \(nameAgePair.1)")
    }
    // */
    
    class PersonPanelView : UIView {
        
        var data : (String, Int) = ("", 20) {
            didSet {
                label.text = "\(data.0) : \(data.1)"
            }
        }
        
        
        weak var label : UILabel!
        weak var negPick : UITextField!
        weak var counterLabel : UILabel!
        weak var neg1 : UIButton!
        //weak var posPick : UITextField!
        weak var pos1 : UIButton!

        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.initSubViews()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.initSubViews()
        }


        private func initSubViews() {
            let nib = UINib(nibName: "PersonPanel", bundle: nil)
            let nibInstance = nib.instantiate(withOwner: self, options: nil)
            
            let nibView = (nibInstance.first) as! UIView
            addSubview(nibView)
            
            label = (nibView.subviews[0].subviews[0] as! UILabel)
            label.text = "\(data.0)"
            
            counterLabel = (nibView.subviews[0].subviews[1] as! UILabel)
            counterLabel.text = "\(data.1)"
            
            negPick = (nibView.subviews[1].subviews[1] as! UITextField)
            negPick.addTarget(self, action: #selector(textFieldReturn(_:)), for: .editingDidEndOnExit)
            
            neg1 = (nibView.subviews[1].subviews[0] as! UIButton)
            neg1.addTarget(self, action: #selector(subtract1(_:)), for: .touchUpInside)
            
            pos1 = (nibView.subviews[1].subviews[2] as! UIButton)
            pos1.addTarget(self, action: #selector(add1(_:)), for: .touchUpInside)
            
//            posPick = (nibView.subviews[1].subviews[3] as! UITextField)
//            posPick.addTarget(self, action: #selector(textFieldReturn(_:)), for: .editingDidEndOnExit)
        }
        
        @objc func textFieldReturn(_ textField: UITextField) -> Bool {
            print(textField.text!)
            data.1 += Int(textField.text ?? "0") ?? 0
            counterLabel.text = "\(data.1)"
            if Int(textField.text ?? "0") ?? 0 < 0 {
                history.append("Subtracting \(textField.text ?? "0") from \(data.0)")
            } else {
                history.append("Adding \(textField.text ?? "0") to \(data.0)")
            }
            textField.text = ""
            disableAdd = true
            loserCheck()
            return true
        }
        
        
        @objc private func subtract1(_ sender : UIButton) {
            
            data = (data.0, data.1 - 1)
            counterLabel.text = "\(data.1)"
            history.append("Subtracting 1 from \(data.0)")
            NSLog(", \(data.0)")
            disableAdd = true
            loserCheck()
        }
        
        @objc private func add1(_ sender : UIButton) {
            
            data = (data.0, data.1 + 1)
            counterLabel.text = "\(data.1)"
            history.append("Adding 1 to \(data.0)")
            NSLog(", \(data.0)")
            disableAdd = true
            loserCheck()
        }
        
        func loserCheck() {
            if data.1 < 1 {
                history.append("\(data.0) Loses!")
                //losers.append(Int(data.0) ?? 1)
                let alert = UIAlertController(title: history[history.count - 1],message:" The above player loses!",
                                              preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK",style:UIAlertAction.Style.default,handler: nil))
                self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
        
//        @objc private func addPick(_ sender : UIButton) {
//
//            let val = Int(negPick.currentTitle ?? "1")
//
//            data = (data.0, data.1 + val!)
//
//            counterLabel.text = "\(data.1)"
//
//            history.append("Adding 1 to \(data.0)")
//
//            NSLog(", \(data.0)")
//        }
    }
}

