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
}
