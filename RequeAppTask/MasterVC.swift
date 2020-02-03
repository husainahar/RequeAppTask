//
//  MasterVC.swift
//  RequeAppTask
//
//  Created by Husain Nahar on 2/3/20.
//  Copyright © 2020 Husain Nahar. All rights reserved.
//

import UIKit

class MasterVC: BaseVC {
    
//    MARK: UI DESIGN
    lazy var whiteView: UIView = {
        let bl = UIView()
        bl.translatesAutoresizingMaskIntoConstraints = false
        bl.backgroundColor = const.WHITE_COLOR
        bl.layer.cornerRadius = 12
        
        return bl
    }()
    
    lazy var cl: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 0
        
        let cl = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        cl.translatesAutoresizingMaskIntoConstraints = false
        cl.delegate = self
        cl.dataSource = self
        cl.backgroundColor = .clear
        cl.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cl.register(CollectionCell.self, forCellWithReuseIdentifier: const.COLLECTIONVIEWCELLID)
        cl.showsVerticalScrollIndicator = false
        
        return cl
    }()
    
//    MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.isModalInPresentation = true
        
        hideAllIcons(bool: false, navTitle: "Restaurants", navPurple: false)
        
        fetchData()
    }
    
//    MARK: CONSTRAINTS
    override func setupViews(){
        const().setGradientBackground(view: self.view, colorTop: #colorLiteral(red: 0.6110240221, green: 0.2487242222, blue: 0.8443751931, alpha: 1), colorBottom: const.PURPLE_COLOR)
        
        super.setupViews()
        
        view.addSubview(whiteView)
        whiteView.addSubview(cl)
        
        whiteView.customAnchor(menuIcon.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topConstant: 20, bottomConstant: 10, leftConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        cl.customAnchor(whiteView.topAnchor, bottom: whiteView.bottomAnchor, left: whiteView.leftAnchor, right: whiteView.rightAnchor, topConstant: 20, bottomConstant: 10, leftConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        setupNVAlertView()
    }
    
//    MARK: VARIABLES
    var decoder: ResponseDecoder?{
        didSet{
            
            if self.decoder?.status ?? Bool(){
                
                if (self.decoder?.result?.count ?? 0) > 0{
                    
                    DispatchQueue.main.async {
                        self.cl.reloadData()
                    }
                }else{
                    
                    self.alertView.showAlert(with: "No products available")
                }
            }else{
                self.alertView.showAlert(with: self.decoder?.message)
            }
        }
    }
    
    
//    MARK: FUNCTIONS
    fileprivate func fetchData(){
        
        self.startAnimate()
        
        HTTPHelper.shared.requestData(with: const.URLSTR, data: nil, httpMethod: .get) { (data) in
            
            self.stopAnimate()
            
            guard let decoder = try? JSONDecoder().decode(ResponseDecoder.self, from: data) else {return}
            
            self.decoder = decoder
        }
    }
}

//MARK: CUSTOMCELL
class CollectionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var img: CustomImageView = {
           let ct = CustomImageView()
//           ct.setIcon(with: "search")
           
           return ct
       }()
       
       lazy var topTitle: BoldSmalWhiteLbl = {
           let bl = BoldSmalWhiteLbl()
           bl.setLblTitle(str: "Restaurants")
           
           return bl
       }()
    
    lazy var bottomTitle: BoldVSmalWhiteLbl = {
        let bl = BoldVSmalWhiteLbl()
        bl.setLblTitle(str: "Restaurants")
        
        return bl
    }()
    
    lazy var lblStackView: UIStackView = {
        let st = UIStackView(arrangedSubviews: [self.topTitle, self.bottomTitle])
        st.spacing = 5
        st.distribution = .fillEqually
        st.translatesAutoresizingMaskIntoConstraints = false
        st.axis = .vertical
        
        return st
    }()
    
    fileprivate func setupViews(){
//        backgroundColor = .clear
        
        layer.masksToBounds = true
        layer.cornerRadius = 12
        
        addChildViews([img])
        
        img.customAnchor(topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topConstant: 0, bottomConstant: 0, leftConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        const().setGradientBackground(view: self, colorTop: .clear, colorBottom: const.PURPLE_COLOR)
        
        addSubview(lblStackView)
        
        lblStackView.customAnchor(nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topConstant: 0, bottomConstant: 10, leftConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 45)
    }
    
    fileprivate func configureCell(product: Product?){
        
        guard let pr = product else {return}
        
        self.img.loadImageUsingUrlString(from: pr.image?.replacingOccurrences(of: " ", with: "%20") ?? "")
        
        self.topTitle.setLblTitle(str: pr.name ?? "")
        
        self.bottomTitle.setLblTitle(str: pr.cur_price ?? "")
    }
}

//MARK: COLLECTIONVIEW DATASOURCE & DELEGATES
extension MasterVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.decoder?.result?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: const.COLLECTIONVIEWCELLID, for: indexPath) as? CollectionCell{
            
            cell.configureCell(product: self.decoder?.result?[indexPath.item])
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cl.frame.width, height: 350)
    }
}
