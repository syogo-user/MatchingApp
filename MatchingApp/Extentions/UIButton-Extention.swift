//
//  UIButton-Extention.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/02/17.
//

import UIKit
extension UIButton{
    func createCardInfoButton() -> UIButton {
        self.setImage(UIImage(systemName:"info")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        self.tintColor = .white
        self.imageView?.contentMode = .scaleAspectFit
        return self
    }
    func createAboutAccountButton(text:String) -> UIButton{
        self.setTitle(text, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 14)
        return self
    }
    func createProfileTopButton(title:String) -> UIButton {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 15)
        return self
    }
    func createProfileEditButton() -> UIButton{
        let image = UIImage(systemName: "square.and.pencil")
        self.setImage(image, for: .normal)
        self.layer.cornerRadius = 30
        self.tintColor = .darkGray
        self.imageView?.contentMode = .scaleAspectFill
        self.backgroundColor = .white
        return self
    }
}
