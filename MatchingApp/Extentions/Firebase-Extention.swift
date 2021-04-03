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
    static func loginWithFireAuth(email:String,password:String, completion:@escaping (Bool) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err{
                print("ログインに失敗",err)
                completion(false)
                return
            }
            print("ログインに成功")
            completion(true)
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
    //Firestoreからユーザを取得
    static func fetchUserFromFirestore(uid:String,completion:@escaping (User?) -> Void){
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err{
                print("ユーザ情報の取得に失敗：" ,err)
                completion(nil)
            }
            guard let dic = snapshot?.data() else{return}
            let user = User(dic:dic)
            completion(user)
        }
    }
    //Firestoreから自分以外のユーザー情報を取得
    static func fetchUsers(completion:@escaping ([User]) -> Void){
        Firestore.firestore().collection("users").getDocuments { (snapshots, err) in
            if let err = err{
                print("ユーザ情報の取得に失敗：" ,err)
                return
            }
//            var users = [User]()
//            snapshots?.documents.forEach({ (snapshot) in
//                let dic = snapshot.data()
//                let user = User(dic:dic)
//                users.append(user)
//            })
            let users = snapshots?.documents.map({ (snapshot) -> User in
                let dic = snapshot.data()
                let user = User(dic:dic)
                return user
            })
            completion(users ?? [User]())
        }
    }
}
