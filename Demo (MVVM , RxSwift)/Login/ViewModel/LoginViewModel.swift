//
//  LoginViewModel.swift
//  Demo (MVVM , RxSwift)
//
//  Created by hamdi on 05/05/2023.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire
class LoginViewModel  {
    var codeBehavior = BehaviorRelay<String>(value: "")
    var phoneBehavior = BehaviorRelay<String>(value: "")
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
   private var loginModelSubject = PublishSubject<LoginSuccessModel>()
    var loginModelObservable :Observable<LoginSuccessModel>{
        return loginModelSubject
    }
    func getData(){
        loadingBehavior.accept(true)
        let params = [
                    "phone": phoneBehavior.value,
                    "password": codeBehavior.value,
                    "player_id": "a0fb941c-ba42-450d-9a09-4e38258f5adb"]
        let headers :HTTPHeaders = ["Content-Type": "application/json"]
        APIServices.instance.getData(url: "https://b-andsweets.com/api/login", method: .post, params: params, encoding: JSONEncoding.default, headers: headers) { [weak self](loginModel:LoginSuccessModel?, baseErrorModel:BaseErrorModel?, error )in
            guard let self = self else{return}
            self.loadingBehavior.accept(false)
            //NetworkError
            if let error = error {
                print (error.localizedDescription)
            }else if let baseErrorModel = baseErrorModel {
                print(baseErrorModel.message)
            }else{
                guard let loginModel = loginModel else{return}
                //observable
                self.loginModelSubject.onNext(loginModel)
                
            }
            
        }
        
    }
}
