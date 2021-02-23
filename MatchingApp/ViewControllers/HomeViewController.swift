//
//  ViewController.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/02/14.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            //レイアウトのセットアップが完了する前に呼ばれると困るので0.5秒後に遷移するように
            let registerController = RegisterViewController()
            registerController.modalPresentationStyle = .fullScreen
            self.present(registerController, animated: true)
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
        

        [
            topControlView.heightAnchor.constraint(equalToConstant:100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)].forEach {$0.isActive = true}
     
    }


}

