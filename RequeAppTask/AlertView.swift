//
//  AlertView.swift
//  RequeAppTask
//
//  Created by Husain Nahar on 2/3/20.
//  Copyright © 2020 Husain Nahar. All rights reserved.
//

import UIKit

class AlertView: UIView {
    var controler: BaseVC?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAlertView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var alertPopup: UIView = {
        let sb = UIView()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.layer.cornerRadius = 10
        sb.backgroundColor = const.WHITE_COLOR
        sb.layer.masksToBounds = true
        
        return sb
    }()
    
    lazy var alertLbl: BoldSmalWhiteLbl = {
        let sl = BoldSmalWhiteLbl()
        
        sl.setLblTitle(str: "ALERT")
        sl.textAlignment = .center
        
        return sl
    }()
    
    lazy var msgLblForAlert: BoldSmalPurpleLbl = {
        let sl = BoldSmalPurpleLbl()
        sl.textAlignment = .center
        sl.numberOfLines = 2
        
        return sl
    }()
    
    lazy var okBtnForAlert: CustomBtn = {
        let li = CustomBtn(type: .system)
        li.setTitl(str: "OK")
        li.addTarget(self, action: #selector(dismissAlertView), for: .touchUpInside)
        li.backgroundColor = .gray
        
        return li
    }()
    
    @objc func dismissAlertView(){
        
        DispatchQueue.main.async {
            self.isHidden = true
            self.controler?.stopAnimate()
        }
    }
    
    func showAlert(with message: String?){
        
        DispatchQueue.main.async {
            if let m = message{
                
                self.msgLblForAlert.setLblTitle(str: m)
            }
            self.isHidden = false
        }
    }
    
    fileprivate func setupAlertView(){
        backgroundColor = UIColor(white: 0, alpha: 0.4)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(alertPopup)
        alertPopup.addChildViews([orangeViewTopForAlert, msgLblForAlert, okBtnForAlert])
        orangeViewTopForAlert.addSubview(alertLbl)
        
        alertPopup.customAnchorWithXY(centerXAnchor, centerY: centerYAnchor, widthConstant: 250, heightConstant: 150)
        
        orangeViewTopForAlert.customAnchor(alertPopup.topAnchor, bottom: nil, left: alertPopup.leftAnchor, right: alertPopup.rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 35)
        
        msgLblForAlert.customAnchorWithY(alertPopup.leftAnchor, right: alertPopup.rightAnchor, centerY: alertPopup.centerYAnchor, leftConstant: 20, rightConstant: 20, widthConstant: 0, heightConstant: 40)
                
        okBtnForAlert.customAnchor(nil, bottom: alertPopup.bottomAnchor, left: alertPopup.leftAnchor, right: alertPopup.rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 35)
        
        alertLbl.customAnchorWithXY(orangeViewTopForAlert.centerXAnchor, centerY: orangeViewTopForAlert.centerYAnchor, widthConstant: 0, heightConstant: 20)
    }
    
    lazy var orangeViewTopForAlert: UIView = {
        let bl = UIView()
        bl.translatesAutoresizingMaskIntoConstraints = false
        bl.backgroundColor = .gray
        
        return bl
    }()
}
