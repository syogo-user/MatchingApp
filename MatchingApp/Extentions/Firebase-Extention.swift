//
//  Firebase-Extention.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/02/23.
//

import Firebase
//MARK:-Auth
extension Auth{
    static  func createUserToFireAuth(email:String?,password:String?,name:String?,completion:@escaping(Bool) -> ()){
        guard let email = email else{ return}
        guard let password = password else{return}
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            //登録後に呼ばれる
            if let err = err {
                print("auth情報の登録に失敗:",err)
                return
            }
            guard let uid = auth?.user.uid else{return}
            print("auth情報の登録に成功",uid)
            Firestore.setUserDataToFirestore(email:email,uid: uid,name:name) { success in
                //あとでよばれる
                completion(success)
            }
        }
                
    }
}
//MARK:-Firesotre
extension Firestore{
    static func setUserDataToFirestore(email:String,uid:String,name:String?, completion: @escaping (Bool) -> () ){
        guard let name = name else {return}
        
        let document = [
            "name":name ,
            "email":email,
            "createdAt":Timestamp()
        ] as [String:Any]
        Firestore.firestore().collection("users").document(uid).setData(document) {
            err in
            if let err = err {
                print("ユーザ情報のfirestoreへの保存に失敗",err)
            }
            //コールバック関数を呼ぶ
            completion(true)
            print("ユーザ情報のfirestoreへの保存が成功")
        }
        
    }

}
