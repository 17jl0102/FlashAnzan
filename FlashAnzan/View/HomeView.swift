//
//  HomeView.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/06/13.
//

import UIKit

@IBDesignable
class HomeView: UIView {
    
    @IBOutlet weak var numberOfQuestionsText: UITextField!
    @IBOutlet weak var digitText: UITextField!
    @IBOutlet weak var displayIntervalText: UITextField!
    
    var digitPicker = UIPickerView()
    let digits:[Int] = ([Int])(1...5)
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
    }
    


    
    
    
    func createDigitPicker() {
        digitPicker.delegate = self
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 40))
        let doneButtonSystemItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: nil)
        let doneButtonStyleItem = UIBarButtonItem(title: "完了", style: .plain, target: self, action: #selector(done))
        toolbar.setItems([doneButtonSystemItem,doneButtonStyleItem], animated: true)
        
        digitText.inputView = digitPicker
        digitText.inputAccessoryView = toolbar
    }
    
    @objc func done() {
        endEditing(true)
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
    
    
}
