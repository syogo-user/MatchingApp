//
//  ProfileImageView.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/04/04.
//

import UIKit
class ProfileImageView :UIImageView{
    init() {
        super.init(frame:.zero)
        self.image = UIImage(named: "toOn")
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 90
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
