//
//  HomeView.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/06/13.
//

import UIKit

@IBDesignable
class HomeView: UIView {
    
    @IBOutlet weak var numberOfQuestionsTextField: UITextField!
    @IBOutlet weak var digitTextField: UITextField!
    @IBOutlet weak var displayIntervalTextField: UITextField!
    
    var digits:[Int] = ([Int])(1...5)
    let digitPicker = UIPickerView()
    var saveValues:Dictionary<String, Int> = [:]
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
        createDigitPicker(digits: digits)
        createToolbar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
        createDigitPicker(digits: digits)
        createToolbar()
    }
    
    enum textFieldKey: String{
        case numberOfQuestion = "numberOfQuestion"
        case digit = "digit"
        case displayInterval = "displayInterval"
        }
    
    func createToolbar() {
        let pickerToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 40))
        let pickerDoneButtonSystemItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(didTapDone))
        pickerToolbar.setItems([pickerDoneButtonSystemItem], animated: true)
        
        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 40))
        let keyboardDoneButtonSystemItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: nil)
        keyboardToolbar.setItems([keyboardDoneButtonSystemItem], animated: true)
        numberOfQuestionsTextField.inputAccessoryView = keyboardToolbar
        digitTextField.inputAccessoryView = pickerToolbar
        displayIntervalTextField.inputAccessoryView = keyboardToolbar
    }
    
    func createDigitPicker(digits:[Int]) {
        digitPicker.delegate = self
        digitPicker.dataSource = self
        digitTextField.inputView = digitPicker
    }
    
    @objc func didTapDone(_ textField: UITextField) {
        var textFieldValue = 0
        switch textField.tag {
        case 0:
            textFieldValue = Int(numberOfQuestionsTextField.text!) ?? 0
            numberOfQuestionsTextField.resignFirstResponder()
            saveValues.updateValue(textFieldValue, forKey: textFieldKey.numberOfQuestion.rawValue)
        case 1:
            digitTextField.resignFirstResponder()
            let index = digitPicker.selectedRow(inComponent: 0)
            digitTextField.text = String(digits[index])
            saveValues.updateValue(digits[index], forKey: textFieldKey.digit.rawValue)
        case 2:
            textFieldValue = Int(displayIntervalTextField.text!) ?? 0
            displayIntervalTextField.resignFirstResponder()
            saveValues.updateValue(textFieldValue, forKey: textFieldKey.displayInterval.rawValue)
        default:
            break
        }
    }
    func alert(alertTitle: String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    private func loadXib() {
        let homeView = Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)?.first as! UIView
        homeView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(homeView)

        homeView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        homeView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        homeView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        homeView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
}

extension HomeView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return digits.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(digits[row]) + "秒"
    }
}
