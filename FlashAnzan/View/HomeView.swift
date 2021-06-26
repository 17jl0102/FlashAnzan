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
    var saveValueDigit:Int = 0
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
        createDigitPicker(digits: digits)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
        createDigitPicker(digits: digits)
    }
    
    
    func createDigitPicker(digits:[Int]) {
        //self.digits = digits
        
        digitPicker.delegate = self
        digitPicker.dataSource = self
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 40))
        let doneButtonSystemItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(didTapDone))
        toolbar.setItems([doneButtonSystemItem], animated: true)
        
        digitTextField.inputView = digitPicker
        digitTextField.inputAccessoryView = toolbar
    }
    
    @objc func didTapDone() {
        digitTextField.resignFirstResponder()
        let index = digitPicker.selectedRow(inComponent: 0)
        digitTextField.text = String(digits[index])
        saveValueDigit = digits[index]
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
        return String(digits[row])
    }
}
