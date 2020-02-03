//
//  Helper.swift
//  RequeAppTask
//
//  Created by Husain Nahar on 2/3/20.
//  Copyright © 2020 Husain Nahar. All rights reserved.
//

import UIKit
import Alamofire

let imageCache = NSCache<NSString, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageURLString: String?
    
    func loadImageUsingUrlString(from urlString: String) {
        
        self.contentMode = .scaleToFill
        self.clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        
        if urlString == ""{
            
            self.setIcon(with: "mainLogo")
            return
        }
        
        imageURLString = urlString
        
        guard let url = URL(string: urlString) else {return}
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error != nil {
                return
            }
            guard let data = data else {return}
            
            DispatchQueue.main.async() {
                guard let imageToCache = UIImage(data: data) else {return}
                
                if self.imageURLString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache, forKey: urlString as NSString)
            }
        }.resume()
    }
}

extension UIImageView{
    
    func setImage(with name: String){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    
    func setIcon(with name: String){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = UIImage(named: name)?.withRenderingMode(.alwaysOriginal)
        self.contentMode = .scaleAspectFit
    }
}

extension String {
    
func isValidEmail() -> Bool {
    // here, `try!` will always succeed because the pattern is valid
    let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
    return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

extension UIView{
    
    public func customAddConstraintsWithFormat(_ format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    
    public func customAnchor(_ top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, bottomConstant: CGFloat = 0, leftConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    public func customAnchorWithX(_ top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, bottomConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorXWithReturnAnchors(top, bottom: bottom, centerX: centerX, topConstant: topConstant, bottomConstant: bottomConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    public func anchorXWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, bottomConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let centerX = centerX {
            
            anchors.append(self.centerXAnchor.constraint(equalTo: centerX))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    public func customAnchorWithY(_ left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, leftConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorYWithReturnAnchors(left, right: right, centerY: centerY, leftConstant: leftConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    public func anchorYWithReturnAnchors(_ left: NSLayoutXAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, leftConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        var anchors = [NSLayoutConstraint]()
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if let centerY = centerY {
            anchors.append(self.centerYAnchor.constraint(equalTo: centerY))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    public func customAnchorWithXY(_ centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorXYWithReturnAnchors(centerX, centerY: centerY, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    public func anchorXYWithReturnAnchors(_ centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        var anchors = [NSLayoutConstraint]()
        
        if let centerX = centerX {
            anchors.append(self.centerXAnchor.constraint(equalTo: centerX))
        }
        
        if let centerY = centerY {
            anchors.append(self.centerYAnchor.constraint(equalTo: centerY))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    func addChildViews(_ views: [UIView]){
        
        views.forEach({self.addSubview($0)})
    }
}

class BoldSmalWhiteLbl: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
    }
    
    func setLblTitle(str: String){
        
        self.attributedText = const.attributedTextBoldSmalWhite(with: str)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BoldVSmalWhiteLbl: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
    }
    
    func setLblTitle(str: String){
        
        self.attributedText = const.attributedTextBoldVSmalWhite(with: str)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BoldSmalPurpleLbl: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontSizeToFitWidth = true
    }
    
    func setLblTitle(str: String){
        
        self.attributedText = const.attributedTextBoldSmalPurple(with: str)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct const {
    static let WHITE_COLOR = UIColor.white
    static let PURPLE_COLOR = #colorLiteral(red: 0.3537592292, green: 0.2046542168, blue: 0.6055527925, alpha: 1)
    static let FONT_SIZE: CGFloat = 16

    static func attributedTextBoldSmalWhite(with str: String) -> NSAttributedString{
        
        return NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: const.WHITE_COLOR, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: FONT_SIZE)])
    }
    
    static func attributedTextBoldVSmalWhite(with str: String) -> NSAttributedString{
        
        return NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: const.WHITE_COLOR, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)])
    }
    
    static func attributedTextBoldSmalPurple(with str: String) -> NSAttributedString{
        
        return NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: const.PURPLE_COLOR, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: FONT_SIZE)])
    }
    
    static func attributedTextBoldSmalGray(with str: String) -> NSAttributedString{
        
        return NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: FONT_SIZE)])
    }
    
    static let COLLECTIONVIEWCELLID = "COLLECTIONVIEWCELLID"
    
    static func validateTextField(_ txtField: UITextField) -> Bool{
        
        if txtField.text == "" || txtField.text == nil {
            
            return true
        }else{
            
            return false
        }
    }
    
    static func validatePasswordCount(_ txtField: UITextField) -> Bool{
        
        if (txtField.text ?? "").count < 6 {
            
            return true
        }else{
            
            return false
        }
    }
    
    static let URLSTR = "http://132.148.0.36/minikin_ws/products.php"
    static let EMAIL = "apptest@reque.com"
    static let PASSWORD = "admin123"
    
    func setGradientBackground(view: UIView, colorTop: UIColor, colorBottom: UIColor) {
        let colorTop =  colorTop.cgColor
        let colorBottom = colorBottom.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.5, 1.0]
        gradientLayer.frame = view.bounds

        view.layer.addSublayer(gradientLayer)
    }
}

class CustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 6
        layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        autocapitalizationType = .none
        textColor = const.PURPLE_COLOR
    }
    
    func setAtr(str: String){
        
        attributedPlaceholder = const.attributedTextBoldSmalGray(with: str)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomBtn: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = const.PURPLE_COLOR
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 6
    }
    
    func setTitl(str: String){
        
        setAttributedTitle(const.attributedTextBoldSmalWhite(with: str), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Data{
    
    func getResponse() -> Parameters{
        
        do{
            let json = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as! Parameters
            
            return json
        }catch let err{
            
            print("ERROR MAKING JSON: \(err.localizedDescription)")
        }
        
        return Parameters()
    }
}
