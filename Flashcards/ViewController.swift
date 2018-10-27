//
//  ViewController.swift
//  Flashcards
//
//  Created by Mateo Choi on 10/13/18.
//  Copyright © 2018 Mateo Choi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backlabel: UILabel!
    @IBOutlet weak var frontlabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        frontlabel.isHidden = true
    }
    func updateFlashcard(question: String, answer: String) {
        frontlabel.text = question
        backlabel.text = answer
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
}

