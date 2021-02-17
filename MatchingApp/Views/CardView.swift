//
//  CardView.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/02/16.
//

import UIKit
class CardView:UIView{
    let cardImageView:UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    let nameLabel :UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .white
        label.text = "Taro , 22"
        return label
    }()

    let infoButton: UIButton = {
        let button = UIButton(type:.system)
        button.setImage(UIImage(systemName:"info")?.resize(size: .init(width: 40, height: 40)), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let residenceLabel :UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .white
        label.text = "日本、大阪"
        return label
    }()
    let hobbyLable :UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.text = "ランニング"
        return label
    }()
    
    
    
    let introductionLabel :UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .white
        label.text = "走り回るのが大好きです。"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panCargView))
        self.addGestureRecognizer(panGesture)//自分自身にpanGestureを設定する
        
    }
    @objc private func panCargView(gesture:UIPanGestureRecognizer){
        let translation = gesture.translation(in: self)
        
        if gesture.state == .changed{
            //動かしているとき
            self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        }else if gesture.state == .ended{
            UIView.animate(withDuration: 0.3) {
                self.transform = .identity //もとの位置に戻す
                self.layoutIfNeeded()
            }
        }
    }

    private func setupLayout(){
        let infoVerticalStackView = UIStackView(arrangedSubviews: [residenceLabel,hobbyLable,introductionLabel])
        infoVerticalStackView.axis = .vertical//縦並び
        
            
        let baseStackView = UIStackView(arrangedSubviews: [infoVerticalStackView ,infoButton])
        baseStackView.axis = .horizontal//横並び
        
        addSubview(cardImageView)
        addSubview(nameLabel)
        addSubview(baseStackView)
        cardImageView.anchor(top:topAnchor,bottom:bottomAnchor,left: leftAnchor,right: rightAnchor,leftPdding: 10,rightPdding: 10)
        infoButton.anchor(width:40)
        baseStackView.anchor(bottom:cardImageView.bottomAnchor,left:cardImageView.leftAnchor,right: cardImageView.rightAnchor,bottomPdding: 20,leftPdding: 20,rightPdding: 20)
        nameLabel.anchor(bottom:baseStackView.topAnchor,left:cardImageView.leftAnchor,bottomPdding: 10,leftPdding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
