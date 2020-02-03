//
//  HttpHelper.swift
//  RequeAppTask
//
//  Created by Husain Nahar on 2/3/20.
//  Copyright © 2020 Husain Nahar. All rights reserved.
//

import Alamofire

class HTTPHelper{

private static var instance: HTTPHelper!

static var shared: HTTPHelper{
    get{
        if instance == nil {
            instance = HTTPHelper()
            }
            return instance
        }
    }
    
    enum HTTPMethodRequest: String{
        case post = "POST"
        case get = "GET"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    func requestData(with urlStr: String, data: Data?, httpMethod: HTTPMethodRequest, completion: @escaping(Data)->Void){
        
        guard let url = URL(string: urlStr) else {return}
        
        var parameters = Parameters()
        
        if data != nil{
            do{
                parameters = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Parameters
                
            }catch let err{
                
                print("ERROR FETCHING PARAMETERES: \(err.localizedDescription)")
            }
        }
        
        Alamofire.request(url, method: .get, parameters: data == nil ? nil : parameters).responseJSON { (response) in
            
            guard response.error == nil else {
                
                print("ERROR CAUGHT: \(response.error.debugDescription)")
                return
            }
                        
            guard let data = response.data else {return}
            
            print("RESPONSE IS: \(data.getResponse())")
            
            completion(data)
        }
    }
}
