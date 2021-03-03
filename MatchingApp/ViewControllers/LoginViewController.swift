//
//  LoginViewController.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/03/03.
//

import UIKit
import RxSwift
import FirebaseAuth
class LoginViewContrller :UIViewController{
    
    private let disposeBag = DisposeBag()
    
    //MARK:UIViews
    private let titleLabel = RegisterTitleLabel(text:"LOGIN")
    private let emailTextField = RegisterTextField(placeHolder: "email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    let loginButton = RegisterButton(text:"ログイン")
    private let dontHaveAccountButton =  UIButton(type:.system).createAboutAccountButton(text: "アカウントをお持ち出ない方はこちら")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupBindings()
    }
    
    private func setupGradientLayer(){
        let layer = CAGradientLayer()
        let startColor = UIColor.rgb(red: 227, green: 48, blue: 78).cgColor
        let endColor = UIColor.rgb(red: 245, green: 208, blue: 108).cgColor
        layer.colors = [startColor,endColor]
        layer.locations  = [0.0,1.3]
        layer.frame = view.bounds
        view.layer.addSublayer(layer)
    }
    private func setupLayout(){
        passwordTextField.isSecureTextEntry = true//パスワードが見えないように設定

        let baseStackView = UIStackView(arrangedSubviews: [emailTextField,passwordTextField,loginButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually //同じ高さに
        baseStackView.spacing = 20
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(dontHaveAccountButton)
        
        emailTextField.anchor(height:45)
        baseStackView.anchor(left:view.leftAnchor,right: view.rightAnchor,centerY: view.centerYAnchor,leftPdding: 40,rightPdding: 40)
        
        titleLabel.anchor(bottom:baseStackView.topAnchor,centerX: view.centerXAnchor,bottomPdding: 20)
        dontHaveAccountButton.anchor(top:baseStackView.bottomAnchor,centerX: view.centerXAnchor,topPdding: 20)
    }
    private func setupBindings(){
        dontHaveAccountButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }.disposed(by: disposeBag)
            
        loginButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.loginWithFireAuth()
            }.disposed(by: disposeBag)
        
    }
    private func loginWithFireAuth(){
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err{
                print("ログインに失敗",err)
                return
            }
            
            print("ログインに成功")
            self.dismiss(animated: true, completion: nil)
        }
    }
}

