//
//  AnserInputView.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/07/18.
//

import UIKit

protocol AnserInputValueDelegate {
    func anserInputValue(value: String)
}

@IBDesignable
class AnserInputView: UIView {
    
    @IBOutlet weak var doubleZeroButton: UIButton!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    
    var delegate: AnserInputValueDelegate?
    var inputValue = ""
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        loadxib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadxib()
    }

    private func loadxib() {
        let anserInputView = Bundle.main.loadNibNamed("AnserInputView", owner: self, options: nil)?.first as! UIView
        anserInputView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(anserInputView)
        anserInputView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        anserInputView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        anserInputView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        anserInputView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    @IBAction func didTapInputOne(_ sender: UIButton) {
        inputValue += "1"
        delegate?.anserInputValue(value: inputValue)
    }
    @IBAction func didTapInputTwo(_ sender: UIButton) {
        inputValue += "2"
        delegate?.anserInputValue(value: inputValue)
    }
    @IBAction func didTapInputThree(_ sender: UIButton) {
        inputValue += "3"
        delegate?.anserInputValue(value: inputValue)
    }
    @IBAction func didTapInputFour(_ sender: UIButton) {
        inputValue += "4"
        delegate?.anserInputValue(value: inputValue)
    }
    @IBAction func didTapInputFive(_ sender: UIButton) {
        inputValue += "5"
        delegate?.anserInputValue(value: inputValue)
    }
    @IBAction func didTapInputSix(_ sender: UIButton) {
        inputValue += "6"
        delegate?.anserInputValue(value: inputValue)
    }
    @IBAction func didTapInputSeven(_ sender: UIButton) {
        inputValue += "7"
        delegate?.anserInputValue(value: inputValue)
    }
    @IBAction func didTapInputEight(_ sender: UIButton) {
        inputValue += "8"
        delegate?.anserInputValue(value: inputValue)
    }
    @IBAction func didTapInputNine(_ sender: UIButton) {
        inputValue += "9"
        delegate?.anserInputValue(value: inputValue)
    }
    @IBAction func didTapInputDoubleZero(_ sender: UIButton) {
        inputValue += "00"
        delegate?.anserInputValue(value: inputValue)
    }
    @IBAction func didTapInputZero(_ sender: UIButton) {
        inputValue += "0"
        delegate?.anserInputValue(value: inputValue)
    }
    @IBAction func didTapInputClear(_ sender: UIButton) {
        inputValue = String(inputValue.dropLast())
        delegate?.anserInputValue(value: inputValue)
    }
}
