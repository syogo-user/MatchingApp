

//
//  RegisterViewController.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/02/17.
//

import UIKit
import RxSwift
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController :UIViewController{

    private let disposeBag = DisposeBag()
    private let viewModel = RegiserViewModel()
    //MARK:UIViews
    private let titleLabel = RegisterTitleLabel(text: "Tinder")
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    let registerButton = RegisterButton(text:"登録")
    private let alreadyHaveAccountButton =  UIButton(type:.system).createAboutAccountButton(text: "すでにアカウントをお持ちの場合はこちら")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupBindins()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //ナビゲーションを非表示
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
    
    //MARK: Methods
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

        let baseStackView = UIStackView(arrangedSubviews: [nameTextField,emailTextField,passwordTextField,registerButton])
        baseStackView.axis = .vertical
        baseStackView.distribution = .fillEqually
        baseStackView.spacing = 20
        view.addSubview(baseStackView)
        view.addSubview(titleLabel)
        view.addSubview(alreadyHaveAccountButton)
        
        nameTextField.anchor(height:45)
        baseStackView.anchor(left:view.leftAnchor,right: view.rightAnchor,centerY: view.centerYAnchor,leftPdding: 40,rightPdding: 40)
        
        titleLabel.anchor(bottom:baseStackView.topAnchor,centerX: view.centerXAnchor,bottomPdding: 20)
        alreadyHaveAccountButton.anchor(top:baseStackView.bottomAnchor,centerX: view.centerXAnchor,topPdding: 20)
    }
    private func setupBindins(){

        //textFieldのbinding
        nameTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                //textが変わったに呼ばれる

                self?.viewModel.nameTextInput.onNext(text ?? "")//onNextでデータをviewModelにわたす

                //textの情報ハンドル


            }
            .disposed(by:disposeBag)

        emailTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                //textが変わったに呼ばれる
                self?.viewModel.emailTextInput.onNext(text ?? "")//onNextでデータをviewModelにわたす
                //textの情報ハンドル


            }
            .disposed(by:disposeBag)

        passwordTextField.rx.text
            .asDriver()
            .drive { [weak self] text in
                //textが変わったに呼ばれる
                self?.viewModel.passwordTextInput.onNext(text ?? "")//onNextでデータをviewModelにわたす
                //textの情報ハンドル


            }
            .disposed(by:disposeBag)

        //buttonのbindings
        registerButton.rx.tap
            .asDriver().drive(){ [weak self]_ in
                //登録ボタンタップ時に呼ばれる
                //登録時の処理
                self?.createUser()
            }
            .disposed(by: disposeBag)

        
        alreadyHaveAccountButton.rx.tap
            .asDriver().drive(){ [weak self]_ in
                //登録ボタンタップ時に呼ばれる
                let login = LoginViewContrller()
                self?.navigationController?.pushViewController(login, animated:true)
                
            }
            .disposed(by: disposeBag)
        
        
        //viewmodelのbinding
        viewModel.validRegisterDriver
            .drive { validAll in
                //流れてくる。
                print("validAll",validAll)
                self.registerButton.isEnabled = validAll
                self.registerButton.backgroundColor = validAll ? .rgb(red: 227, green: 48, blue: 78) : .init(white: 0.7, alpha: 1)
            }
            .disposed(by: disposeBag)



    }
    private func createUser(){
        let email = emailTextField.text
        let password = passwordTextField.text
        let name = nameTextField.text
        Auth.createUserToFireAuth(email: email, password: password, name: name) { success in
            //firebaseに登録後に呼ばれる
            if success{
                print("処理が完了")
                self.dismiss(animated: true)
            } else{

            }
        }
    }

}
