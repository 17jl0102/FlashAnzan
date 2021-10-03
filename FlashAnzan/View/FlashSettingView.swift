//
//  HomeView.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/06/13.
//

import UIKit

protocol FlashValueSetDelegate {
    func numberOfQuestionValueDelivery(numberOfQuestion: Int)
    func digitValueDelivery(digit: Int)
    func intervalValueDelivery(interval: Double)
    func numberOfQuestionCheckAlert()
    func digitCheckAlert()
    func intervalCheckAlert()
}

@IBDesignable
class FlashSettingView: UIView {
    
    @IBOutlet weak var numberOfQuestionTextField: UITextField!
    @IBOutlet weak var digitTextField: UITextField!
    @IBOutlet weak var intervalTextField: UITextField!
    
    var digits:[Int] = ([Int])(1...5)
    let digitPicker = UIPickerView()
    var delegate: FlashValueSetDelegate?
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
        createDigitPicker(digits: digits)
        createNumberOfQuestionToolbar()
        createDigitToolbar()
        createIntervalToolbar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(numberOfQuestionTextFieldChange(numberOfQuestionNotification:)), name: UITextField.textDidChangeNotification, object: numberOfQuestionTextField)
        
        NotificationCenter.default.addObserver(self, selector: #selector(intervalTextFieldChange(intervalNotification:)), name: UITextField.textDidChangeNotification, object: intervalTextField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
        createDigitPicker(digits: digits)
        createNumberOfQuestionToolbar()
        createDigitToolbar()
        createIntervalToolbar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(numberOfQuestionTextFieldChange(numberOfQuestionNotification:)), name: UITextField.textDidChangeNotification, object: numberOfQuestionTextField)
        
        NotificationCenter.default.addObserver(self, selector: #selector(intervalTextFieldChange(intervalNotification:)), name: UITextField.textDidChangeNotification, object: intervalTextField)
    }
    
    func createNumberOfQuestionToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 40))
        let doneButtonSystemItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(didTapNumberOfQuestionDone))
        toolbar.setItems([doneButtonSystemItem], animated: true)
        numberOfQuestionTextField.inputAccessoryView = toolbar
    }
    
    func createDigitToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 40))
        let doneButtonSystemItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(didTapDigitDone))
        toolbar.setItems([doneButtonSystemItem], animated: true)
        digitTextField.inputAccessoryView = toolbar
    }
    
    func createIntervalToolbar() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 40))
        let doneButtonSystemItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(didTapIntervalDone))
        toolbar.setItems([doneButtonSystemItem], animated: true)
        intervalTextField.inputAccessoryView = toolbar
    }
    
    func createDigitPicker(digits:[Int]) {
        digitPicker.delegate = self
        digitPicker.dataSource = self
        digitTextField.inputView = digitPicker
    }
    
    @objc func didTapNumberOfQuestionDone() {
        delegate?.numberOfQuestionCheckAlert()
        numberOfQuestionTextField.resignFirstResponder()
    }
    
    @objc func didTapDigitDone() {
        let index = digitPicker.selectedRow(inComponent: 0)
        digitTextField.text = String(digits[index])
        FlashAnzanManager.flashAnZanShare.digit = digits[index]
        delegate?.digitValueDelivery(digit: FlashAnzanManager.flashAnZanShare.digit)
        digitTextField.resignFirstResponder()
    }
    
    @objc func didTapIntervalDone() {
        delegate?.intervalCheckAlert()
        intervalTextField.resignFirstResponder()
    }
    
    @objc func numberOfQuestionTextFieldChange(numberOfQuestionNotification: Notification) {
        let numberOfQuestionTextField = numberOfQuestionNotification.object as! UITextField
        if let numberOfQuestion = numberOfQuestionTextField.text {
            delegate?.numberOfQuestionValueDelivery(numberOfQuestion: Int(numberOfQuestion) ?? 0)
        }
    }
    
    @objc func intervalTextFieldChange(intervalNotification: Notification) {
        let intervalTextField = intervalNotification.object as! UITextField
        if let interval = intervalTextField.text {
            delegate?.intervalValueDelivery(interval: Double(interval) ?? 0)
        }
    }
    
    private func loadXib() {
        let flashSettingView = Bundle.main.loadNibNamed("FlashSettingView", owner: self, options: nil)?.first as! UIView
        flashSettingView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(flashSettingView)
        
        flashSettingView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        flashSettingView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        flashSettingView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        flashSettingView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}

extension FlashSettingView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return digits.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(digits[row])
    }
}
