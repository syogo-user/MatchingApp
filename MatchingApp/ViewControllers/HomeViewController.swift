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
        view.backgroundColor = .white
        let view1 = TopControlView()
        let view2 = UIView()
        view2.backgroundColor = .blue
        let bottomControlView = BottomControlView()
        let stackView  = UIStackView(arrangedSubviews: [view1,view2,bottomControlView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical //縦
        self.view.addSubview(stackView)
        

        [
            view1.heightAnchor.constraint(equalToConstant:100),
            bottomControlView.heightAnchor.constraint(equalToConstant: 120),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor)].forEach {$0.isActive = true}
        
    }


}
