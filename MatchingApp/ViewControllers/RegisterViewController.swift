//
//  RegisterViewController.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/02/17.
//

import UIKit
class RegisterViewController :UIViewController{
    
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    
//    let nameTextField :UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "名前"
//        textField.borderStyle = .roundedRect//角丸
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
//    let emailTextField :UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "名前"
//        textField.borderStyle = .roundedRect//角丸
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
//    let passwordTextField :UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "名前"
//        textField.borderStyle = .roundedRect//角丸
//        textField.font = .systemFont(ofSize: 14)
//        return textField
//    }()
    let registerButton :UIButton = {
        let button = UIButton()
        button.setTitle("登録", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white , for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        let baseStackView = UIStackView(arrangedSubviews: [nameTextField,emailTextField,passwordTextField,registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        view.addSubview(baseStackView)
        nameTextField.anchor(height:45)
        baseStackView.anchor(left:view.leftAnchor,right: view.rightAnchor,centerY: view.centerYAnchor,leftPdding: 40,rightPdding: 40)
        

    }
}
