//
//  ViewController.swift
//  introduce_myself
//
//  Created by Leonardo Villalobos on 1/24/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var academicYearSegmentController: UISegmentedControl!
    @IBOutlet weak var numPetsLabel: UILabel!
    @IBOutlet weak var numPetsStepper: UIStepper!
    @IBOutlet weak var wantsMorePetsSwitch: UISwitch!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Code source for dismissing keyboard on tap => https://stackoverflow.com/a/48592991
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() { view.endEditing(true) }
    
    @IBAction func numPetsStepperChanged(_ sender: UIStepper) { numPetsLabel.text = String(Int(sender.value)) }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        let textFields: [String: String] = [
            firstNameLabel.text!: firstNameTextField.text!,
            lastNameLabel.text!: lastNameTextField.text!,
            schoolNameLabel.text!: schoolNameTextField.text!,
        ]
        for label in textFields.keys {
            if textFields[label]!.isEmpty {
                alertEmptyTextField(label)
                return
            }
        }
        
        let year: String = academicYearSegmentController.titleForSegment(at: academicYearSegmentController.selectedSegmentIndex)!
        let message: String = (
            "Hey! I'm \(trim(firstNameTextField.text!)) \(trim(lastNameTextField.text!)) and I'm a \(year.lowercased()) year student " +
            "attending \(trim(schoolNameTextField.text!)). I have \(numPetsLabel.text!) \(Int(numPetsLabel.text!) == 1 ? "pet" : "pets") " +
            "and would \(wantsMorePetsSwitch.isOn ? "" : "not") like to have more."
        )
        let alert = UIAlertController(title: "Welcome", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Nice", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
    internal func alertEmptyTextField(_ textFieldName: String) {
        let alert = UIAlertController(title: "Error", message: "\(textFieldName) cannot be empty.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
}

internal func trim(_ str: String) -> String { return str.trimmingCharacters(in: CharacterSet(charactersIn: " ")) }
