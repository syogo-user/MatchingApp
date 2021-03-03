//
//  ViewController.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/02/14.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController {
    
    let logoutButton:UIButton = {
        let button = UIButton(type:.system)
        button.setTitle("ログアウト", for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser?.uid == nil{
            //ログアウトされていたら、画面遷移
            let registerController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }        
    }
    
    
    private func setupLayout(){
        view.backgroundColor = .white
        let topControlView = TopControlView()
        let cardView = CardView()
        let bottomControlView = BottomControlView()
        let stackView  = UIStackView(arrangedSubviews: [topControlView,cardView,bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical //縦
        self.view.addSubview(stackView)
        self.view.addSubview(logoutButton)

        [
            topControlView.heightAnchor.constraint(equalToConstant:100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)].forEach {$0.isActive = true}
     
        logoutButton.anchor(bottom:view.bottomAnchor,left:view.leftAnchor,bottomPdding: 10,leftPdding: 10)
        
        logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
        
    }
    @objc private func tappedLogoutButton(){
        do{
           try Auth.auth().signOut()
            let registerController = RegisterViewController()
            let nav = UINavigationController(rootViewController: registerController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
        }catch{
            //errorの変数がデフォルトで用意されている
            print("ログアウト",error)
        }

    }

}

