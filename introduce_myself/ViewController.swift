//
//  ViewController.swift
//  introduce_myself
//
//  Created by Leonardo Villalobos on 1/24/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var schoolNameTextField: UITextField!
    @IBOutlet weak var academicYearSegmentController: UISegmentedControl!
    @IBOutlet weak var numPetsLabel: UILabel!
    @IBOutlet weak var numPetsStepper: UIStepper!
    @IBOutlet weak var wantsMorePetsSwitch: UISwitch!
    @IBOutlet weak var continueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Code source for dismissing keyboard on tap => https://stackoverflow.com/a/48592991
        let tap = UITapGestureRecognizer(target: self, action: #selector(
            UIInputViewController.dismissKeyboard
        ))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() { view.endEditing(true) }
    
    @IBAction func numPetsStepperChanged(_ sender: UIStepper) {
        numPetsLabel.text = String(Int(sender.value))
    }
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        let textFields: [String: String] = [
            "First name": firstNameTextField!.text!,
            "Last name": lastNameTextField!.text!,
            "School name": schoolNameTextField!.text!,
        ]
        for label in textFields.keys {
            if textFields[label]!.isEmpty {
                alertEmptyTextField(label)
                return
            }
        }
        
        let year: String = academicYearSegmentController.titleForSegment(
            at: academicYearSegmentController.selectedSegmentIndex
        )!
        var message: String = (
            "Hey! I'm \(trim(firstNameTextField.text!)) \(trim(lastNameTextField.text!)) and I'm a " +
            "\(year.lowercased()) year student attending \(trim(schoolNameTextField.text!)). " +
            "I have \(numPetsLabel.text!) \(Int(numPetsLabel.text!) == 1 ? "pet" : "pets")"
        )
        if wantsMorePetsSwitch.isOn {
            message += " and would like to have more."
        } else {
            message += ", but would not like any more."
        }
        
        let alert = UIAlertController(title: "Welcome", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Nice", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
    
    private func alertEmptyTextField(_ textFieldName: String) {
        let alert = UIAlertController(title: "Error", message: "\(textFieldName) cannot be empty.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true, completion: nil)
    }
}

func trim(_ str: String) -> String  {
    return str.trimmingCharacters(in: CharacterSet(charactersIn: " "))
}
