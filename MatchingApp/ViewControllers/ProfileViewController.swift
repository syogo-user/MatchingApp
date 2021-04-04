//
//  ProfileViewController.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/04/04.
//

import UIKit
class ProfileViewController:UIViewController{
    
    private let cellId = "cellId"
    
    let saveButton = UIButton(type:.system).createProfileTopButton(title: "保存")
    let logoutButton = UIButton(type:.system).createProfileTopButton(title: "ログアウト")
    let profileImageView = ProfileImageView()
    let nameLabel = ProfileLabel()
    let profileEditButton = UIButton(type: .system).createProfileEditButton()
    
    lazy var infoCollectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .brown
        cv.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()


    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    private func setupLayout(){
        view.backgroundColor = .white
        nameLabel.text = "test test"
        
        view.addSubview(saveButton)
        view.addSubview(logoutButton)
        view.addSubview(nameLabel)
        view.addSubview(profileImageView)
        view.addSubview(profileEditButton)
        view.addSubview(infoCollectionView)
        saveButton.anchor(top:view.topAnchor,left:view.leftAnchor,topPdding: 20,leftPdding: 15)
        logoutButton.anchor(top:view.topAnchor,right:view.rightAnchor,topPdding: 20,rightPdding: 15)
        profileImageView.anchor(top:view.topAnchor,centerX: view.centerXAnchor,width:180,height: 180,topPdding: 60)
        nameLabel.anchor(top:profileImageView.bottomAnchor,centerX: view.centerXAnchor,topPdding: 20)
        profileEditButton.anchor(top:profileImageView.topAnchor,right:profileImageView.rightAnchor,width: 60,height: 60)
        infoCollectionView.anchor(top:nameLabel.bottomAnchor,bottom:view.bottomAnchor,left: view.leftAnchor,right:view.rightAnchor,topPdding: 20)
    }
}

//MARK: -UICollectionViewDelegate,UICollectionViewDataSource
extension ProfileViewController :UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  infoCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! InfoCollectionViewCell
        return cell
    }
    
    
}
//TODO:別のファイルに分ける
class InfoCollectionViewCell:UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
