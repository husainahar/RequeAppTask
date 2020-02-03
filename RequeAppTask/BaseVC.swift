//
//  BaseVC.swift
//  RequeAppTask
//
//  Created by Husain Nahar on 2/3/20.
//  Copyright © 2020 Husain Nahar. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class BaseVC: UIViewController {
    
    //    MARK: UI DESIGN
    lazy var nv: NVActivityIndicatorView = {
        let nv = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: NVActivityIndicatorType.ballScaleRippleMultiple, color: const.PURPLE_COLOR, padding: nil)
        nv.translatesAutoresizingMaskIntoConstraints = false
        
        return nv
    }()
    
    lazy var menuIcon: CustomImageView = {
        let ct = CustomImageView()
        ct.setIcon(with: "menu")
        
        return ct
    }()
    
    lazy var filterIcon: CustomImageView = {
        let ct = CustomImageView()
        ct.setIcon(with: "filter")
        
        return ct
    }()
    
    lazy var searchIcon: CustomImageView = {
        let ct = CustomImageView()
        ct.setIcon(with: "search")
        
        return ct
    }()
    
    lazy var iconStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [self.searchIcon, self.filterIcon])
        st.spacing = 10
        st.distribution = .fillEqually
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .horizontal

        return st
    }()
    
    lazy var navTitle: BoldSmalWhiteLbl = {
        let bl = BoldSmalWhiteLbl()
        bl.setLblTitle(str: "Restaurants")
        
        return bl
    }()
    
    lazy var alertView: AlertView = {
        let al = AlertView()
        al.controler = self
        al.isHidden = true
        
        return al
    }()

    //    MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    
    //    MARK: CONSTRAINTS
    func setupViews(){
        
        view.addChildViews([self.menuIcon, self.iconStackView, self.navTitle])
        
        menuIcon.customAnchor(view.safeAreaLayoutGuide.topAnchor, bottom: nil, left: view.leftAnchor, right: nil, topConstant: 10, bottomConstant: 0, leftConstant: 10, rightConstant: 0, widthConstant: 25, heightConstant: 25)
        
        iconStackView.customAnchor(menuIcon.topAnchor, bottom: menuIcon.bottomAnchor, left: nil, right: view.rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 10, widthConstant: 60, heightConstant: 0)
        
        navTitle.customAnchorWithXY(view.centerXAnchor, centerY: menuIcon.centerYAnchor, widthConstant: 0, heightConstant: 20)        
    }
    
    //    MARK: FUNCTIONS
    
    func setupNVAlertView(){
        
        view.addChildViews([nv, alertView])
        
        nv.customAnchorWithXY(view.centerXAnchor, centerY: view.centerYAnchor, widthConstant: 50, heightConstant: 50)
        
        alertView.customAnchor(menuIcon.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func hideAllIcons(bool: Bool, navTitle: String, navPurple: Bool){
                    
            [self.menuIcon, self.filterIcon, self.searchIcon].forEach({$0.isHidden = bool})
        
        self.navTitle.attributedText = navPurple ? const.attributedTextBoldSmalPurple(with: navTitle) : const.attributedTextBoldSmalWhite(with: navTitle)
    }
    
    func startAnimate(){
        nv.startAnimating()
    }
    
    func stopAnimate(){
                DispatchQueue.main.async {
        self.nv.stopAnimating()
        }
    }
}
