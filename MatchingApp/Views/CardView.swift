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
        iv.contentMode = .scaleAspectFill
        iv.image = UIImage(named: "night sky")
        iv.clipsToBounds = true
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
    
    let goodLabel :UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 45)
        label.text = "GOOD"
        label.textColor = UIColor.rgb(red:137,green: 223,blue: 86)
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.rgb(red:137,green: 223,blue: 86).cgColor
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()
    let nopeLabel :UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 45)
        label.text = "NOPE"
        label.textColor = UIColor.rgb(red:222,green: 110,blue: 110)
        label.layer.borderWidth = 3
        label.layer.borderColor = UIColor.rgb(red:222,green: 110,blue: 110).cgColor
        label.layer.cornerRadius = 10
        label.textAlignment = .center
        label.alpha = 0
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
            self.handlePanChange(translation: translation)
        }else if gesture.state == .ended{
            self.handlePnaEnded()
        }
    }
    private func handlePanChange(translation:CGPoint){
        //カードの動き
        let degree : CGFloat = translation.x / 20
        let angle = degree * .pi / 100  //回転
        let rotateTranslation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotateTranslation.translatedBy(x: translation.x, y: translation.y)
        
        let ratio :CGFloat = 1 / 100
        let ratioValue = ratio * translation.x
        if translation.x > 0 {
            //右側に移動しているとき
            self.goodLabel.alpha = ratioValue
        } else if translation.x < 0{
            //左側に移動しているとき
            self.nopeLabel.alpha = -ratioValue
        }
        
    }
    private func handlePnaEnded(){
        //カードのもとに戻る動き
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: []) {
            self.transform = .identity //もとの位置に戻す
            self.layoutIfNeeded()
            self.goodLabel.alpha = 0
            self.nopeLabel.alpha = 0
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
        addSubview(goodLabel)
        addSubview(nopeLabel)
        
        cardImageView.anchor(top:topAnchor,bottom:bottomAnchor,left: leftAnchor,right: rightAnchor,leftPdding: 10,rightPdding: 10)
        infoButton.anchor(width:40)
        baseStackView.anchor(bottom:cardImageView.bottomAnchor,left:cardImageView.leftAnchor,right: cardImageView.rightAnchor,bottomPdding: 20,leftPdding: 20,rightPdding: 20)
        nameLabel.anchor(bottom:baseStackView.topAnchor,left:cardImageView.leftAnchor,bottomPdding: 10,leftPdding: 20)
        
        goodLabel.anchor(top:cardImageView.topAnchor,left:cardImageView.leftAnchor,width: 140,height: 55,topPdding: 25 ,leftPdding: 20)
        nopeLabel.anchor(top:cardImageView.topAnchor,right:cardImageView.rightAnchor,width:140,height: 55,topPdding: 25,rightPdding: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
