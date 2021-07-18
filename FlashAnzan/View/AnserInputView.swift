//
//  AnserInputView.swift
//  FlashAnzan
//
//  Created by 角谷　悠平 on 2021/07/18.
//

import UIKit

@IBDesignable
class AnserInputView: UIView {
    
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
}
