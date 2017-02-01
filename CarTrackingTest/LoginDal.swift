//
//  LoginDal.swift
//  CarTrackingTest
//
//  Created by M-Hashem on 1/31/17.
//  Copyright © 2017 M-Hashem. All rights reserved.
//

import Foundation

protocol ILoginDal {
    func Login(Username:String,passWord:String,callback:@escaping (_ sucess:Bool,_ message:String)->())

    
}

class LoginDal:ILoginDal
{
     func Login(Username:String,passWord:String,callback:@escaping (_ sucess:Bool,_ message:String)->())
     {
        let RequestParameters : NSDictionary =
            [
                "un" : Username,
                "up" : passWord,
            ]
        
        let RequestParametersString =  NetworkHelper.DictionaryToJSON(InjectedDictionary: RequestParameters)
        
        NetworkHelper.RequestHelper(domainusrl: nil, service: WebServiceMethods.Login.rawValue, hTTPMethod: .post, parameters: nil,httpBody: RequestParametersString,httpBodyData:  nil,
                                    
                                    callbackString: { (response) in
                                        var sucess = false;
                                        var message = "unhandeled Error";
                                        if let Error = response.error
                                        {
                                            message = Error.localizedDescription
                                        }
                                        else
                                        {
                                            
                                            let result = M_Response(json: response.result.value)
                                            
                                            if (result.status == "success")
                                            {
                                                message = "logind in"
                                                sucess = true
                                            }
                                            else
                                            {
                                               message = result.message!
                                            }
                                        }
                                        callback(sucess,message)
                                        
        },callbackDictionary:nil)
        
     }
}



