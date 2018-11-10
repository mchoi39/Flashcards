//
//  ViewController.swift
//  Flashcards
//
//  Created by Mateo Choi on 10/13/18.
//  Copyright © 2018 Mateo Choi. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var backlabel: UILabel!
    @IBOutlet weak var frontlabel: UILabel!
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
    }

    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    // Array to hold flashcards
    var flashcards = [Flashcard]()
    
    // Current Flashcard Index
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backlabel.layer.cornerRadius = 20.0
        backlabel.clipsToBounds = true
        backlabel.layer.shadowRadius = 15.0
        backlabel.layer.shadowOpacity = 0.2
        frontlabel.layer.cornerRadius = 20.0
        frontlabel.clipsToBounds = true
        frontlabel.layer.shadowRadius = 15.0
        frontlabel.layer.shadowOpacity = 0.2
        
        // Do any additional setup after loading the view, typically from a nib.
        readSavedFlashcards()
        if flashcards.count == 0 {
            updateFlashcard(question: "what is the capital of brazil", answer: "brasilia")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if frontlabel.isHidden == true {
            frontlabel.isHidden = false
        }
        else if frontlabel.isHidden == false{
            frontlabel.isHidden = true
        }
    }
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        frontlabel.text = flashcard.question
        backlabel.text = flashcard.answer
    
        flashcards.append(flashcard)
        print("Added new flashcard")
        print("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count - 1
        print("Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        frontlabel.text = currentFlashcard.question
        backlabel.text = currentFlashcard.answer
    }
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
    }
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
            }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
}

