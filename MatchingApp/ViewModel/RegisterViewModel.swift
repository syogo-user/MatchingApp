//
//  RegiserViewModel.swift
//  MatchingApp
//
//  Created by Uske on 2021/02/11.
//

import Foundation
import RxSwift
import RxCocoa

protocol RegisterViewModelInputs {
    var nameTextInput: AnyObserver<String> { get }
    var emailTextInput: AnyObserver<String> { get }
    var passwordTextInput: AnyObserver<String> { get }
}

protocol RegisterViewModelOutputs {
    var nameTextOutput: PublishSubject<String> { get }
    var emailTextOutput: PublishSubject<String> { get }
    var passwordTextOutput: PublishSubject<String> { get }
}

class RegiserViewModel: RegisterViewModelInputs, RegisterViewModelOutputs {
    
    private let disposeBag = DisposeBag()
    
    // MARK: observable
    var nameTextOutput = PublishSubject<String>()
    var emailTextOutput = PublishSubject<String>()
    var passwordTextOutput = PublishSubject<String>()
    var validRegisterSubject = BehaviorSubject<Bool>(value: false)
    
    // MARK: observer
    var nameTextInput: AnyObserver<String> {
        nameTextOutput.asObserver()
    }
    
    var emailTextInput: AnyObserver<String> {
        emailTextOutput.asObserver()
    }
    
    var passwordTextInput: AnyObserver<String> {
        passwordTextOutput.asObserver()
    }
    
    var validRegisterDriver: Driver<Bool> = Driver.never()
        
    init() {
        
        validRegisterDriver = validRegisterSubject
            .asDriver(onErrorDriveWith: Driver.empty())
        
        let nameValid = nameTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }

        let emailValid = emailTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }

        let passwordValid = passwordTextOutput
            .asObservable()
            .map { text -> Bool in
                return text.count >= 5
            }

        Observable.combineLatest(nameValid, emailValid, passwordValid) { $0 && $1 && $2 }
            .subscribe { validAll in
                self.validRegisterSubject.onNext(validAll)
            }
            .disposed(by: disposeBag)
    }
    
}

////
////  RegisterViewModel.swift
////  MatchingApp
////
////  Created by 小野寺祥吾 on 2021/02/21.
////
//
//import Foundation
//import RxSwift
//import RxCocoa
//
//protocol RegisterViewModelInputs {
//    var nameTextInput: AnyObserver<String>{get}
//    var emailTextInput: AnyObserver<String>{get}
//    var passwordTextInput: AnyObserver<String>{get}
//}
//
//protocol RegisterViewModelOutputs{
//    var nameTextOutput:PublishSubject<String>{get}
//    var emailTextOutput:PublishSubject<String>{get}
//    var passwordTextOutput:PublishSubject<String>{get}
//}
//
//class RegisterViewModel:RegisterViewModelInputs,RegisterViewModelOutputs {
//
//    private let disposeBag = DisposeBag()
//
//    //MARK:observable ViewModelから出ていく情報
//    var nameTextOutput = PublishSubject<String>()
//    var emailTextOutput = PublishSubject<String>()
//    var passwordTextOutput = PublishSubject<String>()
//    var validRegisterSubject = BehaviorSubject<Bool>(value: false)
//
//
//    //MARK:obser ViewModelに入ってくる情報
//    var nameTextInput:AnyObserver<String> {
//        nameTextOutput.asObserver()
//    }
//    var emailTextInput:AnyObserver<String> {
//        emailTextOutput.asObserver()
//    }
//    var passwordTextInput:AnyObserver<String> {
//        passwordTextOutput.asObserver()
//    }
//
//    var validRegisterDriver:Driver<Bool> = Driver.never()
//
//    init() {
//
//        validRegisterDriver = validRegisterSubject.asDriver(onErrorDriveWith:Driver.empty())
//
//
//        //５文字以上だったらtrueがnameValidに入る
//        let nameValid =  nameTextOutput
//            .asObservable()
//            .map { text -> Bool in
//                print("nameValid")
//                return text.count >= 5
//            }
//
//
//        let emailValid =  emailTextOutput
//            .asObservable()
//            .map { text -> Bool in
//                return text.count >= 5
//            }
//
//        let passwordValid = passwordTextOutput
//            .asObservable()
//            .map { text -> Bool in
//                return text.count >= 5
//            }
//
//        Observable.combineLatest(nameValid, emailValid, passwordValid){  $0 && $1 && $2 }
//            .subscribe { validAll in
//                //全部が５文字以上かどうかをtrue or falseで渡す
//                self.validRegisterSubject.onNext(validAll)
//            }
//            .disposed(by: disposeBag)
//    }
//}
