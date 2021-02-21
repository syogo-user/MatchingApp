//
//  RegisterViewModel.swift
//  MatchingApp
//
//  Created by 小野寺祥吾 on 2021/02/21.
//

import Foundation
import RxSwift


class RegisterViewModel {
    
    private let disposeBag = DisposeBag()
    
    //MARK:observable ViewModelから出ていく情報
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    
    
    //MARK:obser ViewModelに入ってくる情報
    var nameTextInput:AnyObserver<String> {
        nameTextOutput.asObserver()
    }
    var emailTextInput:AnyObserver<String> {
        emailTextOutput.asObserver()
    }
    var passwordTextInput:AnyObserver<String> {
        passwordTextOutput.asObserver()
    }
    
    init() {
        nameTextOutput
            .asObservable()
            .subscribe { text in
            print("name:",text)
        }.disposed(by: disposeBag)
        
        emailTextOutput
            .asObservable()
            .subscribe { text in
            print("email:",text)
        }.disposed(by: disposeBag)
        
        passwordTextOutput
            .asObservable()
            .subscribe { text in
            print("password:",text)
        }.disposed(by: disposeBag)

    }
}
