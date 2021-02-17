//
//  RegisterTextField.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/02/17.
//

import UIKit
class RegisterTextField :UITextField {
    init(placeHolder:String) {
        super.init(frame: .zero)
        placeholder = placeHolder
        borderStyle = .roundedRect//角丸
        font = .systemFont(ofSize: 14)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
