//
//  CardImageView.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/02/17.
//

import UIKit
class CardImageView:UIImageView{
    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
        image = UIImage(named:"blueWing")
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
