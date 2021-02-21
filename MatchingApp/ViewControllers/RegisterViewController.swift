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
    private let viewModel = RegisterViewModel()
    //MARK:UIViews
    private let titleLabel = RegisterTitleLabel()
    private let nameTextField = RegisterTextField(placeHolder: "名前")
    private let emailTextField = RegisterTextField(placeHolder: "email")
    private let passwordTextField = RegisterTextField(placeHolder: "password")
    let registerButton = RegisterButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientLayer()
        setupLayout()
        setupBindins()

        

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
        
        nameTextField.anchor(height:45)
        baseStackView.anchor(left:view.leftAnchor,right: view.rightAnchor,centerY: view.centerYAnchor,leftPdding: 40,rightPdding: 40)
        titleLabel.anchor(bottom:baseStackView.topAnchor,centerX: view.centerXAnchor,bottomPdding: 20)
    }
    private func setupBindins(){
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
                self?.viewModel.nameTextInput.onNext(text ?? "")//onNextでデータをviewModelにわたす
                //textの情報ハンドル
                
                
            }
            .disposed(by:disposeBag)
        
        
        registerButton.rx.tap
            .asDriver().drive(){ [weak self]_ in
                //登録ボタンタップ時に呼ばれる
                //登録時の処理
                self?.createUserToFireAuth()
            }
            .disposed(by: disposeBag)
        
    }
    private func createUserToFireAuth(){
        guard let email = emailTextField.text else{ return}
        guard let password = passwordTextField.text else{return}
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            //登録後に呼ばれる
            if let err = err {
                print("auth情報の登録に失敗:",err)
                return
            }
            guard let uid = auth?.user.uid else{return}
            print("auth情報の登録に成功",uid)
            self.setUserDataToFirestore(email:email,uid: uid)
        }
                
    }
    private func setUserDataToFirestore(email:String,uid:String){
        guard let name = nameTextField.text else {return}
        
        let document = [
            "name":name ,
            "email":email,
            "createdAt":Timestamp()
        ] as [String:Any]
        Firestore.firestore().collection("users").document(uid).setData(document) {
            err in
            if let err = err {
                print("ユーザ情報のfirestoreへの保存に失敗",err)
            }
            
            print("ユーザ情報のfirestoreへの保存が成功")
        }
        
    }
    

}
