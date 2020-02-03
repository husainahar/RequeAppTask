//
//  LoginVC.swift
//  RequeAppTask
//
//  Created by Husain Nahar on 2/3/20.
//  Copyright © 2020 Husain Nahar. All rights reserved.
//

import UIKit

class LoginVC: BaseVC {
    
//    MARK: UI DESIGN
    lazy var emailLbl: BoldSmalPurpleLbl = {
        let el = BoldSmalPurpleLbl()
        el.setLblTitle(str: "EMAIL IS: \(const.EMAIL)")
        
        return el
    }()
    
    lazy var passwordLbl: BoldSmalPurpleLbl = {
        let el = BoldSmalPurpleLbl()
        el.setLblTitle(str: "PASSWORD IS: \(const.PASSWORD)")
        
        return el
    }()
    
    lazy var lblStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [self.emailLbl, self.passwordLbl])
        st.spacing = 10
        st.translatesAutoresizingMaskIntoConstraints = false
        st.distribution = .fillEqually
        st.axis = .vertical
        
        return st
    }()
    
    lazy var loginBtn: CustomBtn = {
        let bt = CustomBtn(type: .system)
        bt.setTitl(str: "LOGIN")
        bt.addTarget(self, action: #selector(self.btnPresed), for: .touchUpInside)
        
        return bt
    }()
    
    lazy var emailTxtField: CustomTextField = {
        let tl = CustomTextField()
        tl.setAtr(str: "Enter Email")
        
        return tl
    }()
    
    lazy var paswordTxtField: CustomTextField = {
        let tl = CustomTextField()
        tl.setAtr(str: "Enter password")
        
        return tl
    }()
    
    lazy var txtFieldStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [self.emailTxtField, self.paswordTxtField, self.loginBtn])
        st.spacing = 20
        st.translatesAutoresizingMaskIntoConstraints = false
        st.distribution = .fillEqually
        st.axis = .vertical
        
        return st
    }()
    
    
//    MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideAllIcons(bool: true, navTitle: "Login Page", navPurple: true)
    }
    
//    MARK: CONSTRAINTS
    override func setupViews(){
        super.setupViews()
        
        view.backgroundColor = const.WHITE_COLOR
        
        view.addChildViews([txtFieldStackView, lblStackView])
        
        txtFieldStackView.customAnchorWithY(view.leftAnchor, right: view.rightAnchor, centerY: view.centerYAnchor, leftConstant: 50, rightConstant: 50, widthConstant: 0, heightConstant: 160)
        
        lblStackView.customAnchorWithX(menuIcon.bottomAnchor, bottom: nil, centerX: view.centerXAnchor, topConstant: 40, bottomConstant: 0, widthConstant: 0, heightConstant: 50)
        
        setupNVAlertView()
    }
    
//    MARK: VARIABLES
    
    
//    MARK: FUNCTIONS
    @objc fileprivate func btnPresed(){
        
        if !(self.emailTxtField.text?.isValidEmail() ?? Bool()){
            
            self.alertView.showAlert(with: "Enter valid email")
            
        }else if const.validatePasswordCount(self.paswordTxtField){
            
            self.alertView.showAlert(with: "Enter valid password")
            
        }else{
            self.startAnimate()
            
            if self.emailTxtField.text == const.EMAIL && self.paswordTxtField.text == const.PASSWORD{
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.present(MasterVC(), animated: true, completion: nil)
                }
            }else{
                
                self.alertView.showAlert(with: "Email or Password is incorrect")
            }
        }
    }
}
