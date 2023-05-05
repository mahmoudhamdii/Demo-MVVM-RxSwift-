//
//  LoginViewController.swift
//  Demo (MVVM , RxSwift)
//
//  Created by hamdi on 05/05/2023.
//

import UIKit
import RxSwift
import RxCocoa
import ProgressHUD
class LoginViewController: UIViewController {
    let loginViewModel = LoginViewModel()
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var phoneTXF: UITextField!
    
    @IBOutlet weak var codeTXF: UITextField!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       bindTXFToViewModel()
        subscripeToResponse()
        subscribeToLoginButton()
        subscribeToLoading()
    }
    func subscripeToResponse(){
        loginViewModel.loginModelObservable.subscribe { loginModel in
            print(loginModel)
            
        }.disposed(by: disposeBag)
    }
    func bindTXFToViewModel(){
        phoneTXF.rx.text.orEmpty.bind(to: loginViewModel.phoneBehavior).disposed(by: disposeBag)
        codeTXF.rx.text.orEmpty.bind(to: loginViewModel.codeBehavior).disposed(by: disposeBag)
        
    }
    func subscribeToLoading(){
        loginViewModel.loadingBehavior.subscribe { isLoading in
            if isLoading {
                ProgressHUD.show()
            }else{
                ProgressHUD.dismiss()
            }
        }.disposed(by: disposeBag)
    }
    func subscribeToLoginButton(){
        loginBtn.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance).subscribe {[weak self] _ in
            guard let self = self else {return}
            self.loginViewModel.getData()
                    }.disposed(by: disposeBag)
    }


   
    

}
