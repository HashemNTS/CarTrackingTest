//
//  NetworkHelper.swift
//  Triage
//
//  Created by Mohamed Helmy on 4/13/16.
//  Copyright © 2016 appsinnovate. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum Method : String{
    case get="GET"
    case post="POST"
    
}

enum ResponseType : Int{
    case StringJson = 0
    case DictionaryJson = 1
    
}
class NetworkHelper
{
    
    internal static func RequestHelper(domainusrl:String?,service:String , hTTPMethod: Method,parameters: [String:AnyObject]?, httpBody:String?, httpBodyData:NSData? = nil
        ,responseType: ResponseType = .StringJson, callbackString: ((DataResponse<String>) -> Void)?
        , callbackDictionary: ((_ JSON: JSON, _ Error: Error?) -> Void)?)
    {
        let UrlString = (domainusrl == nil ? AppDelegate.domainurl : domainusrl!)+service;
        let url = URL(string: UrlString)!
        var request = URLRequest(url: url)
        request.httpMethod = hTTPMethod.rawValue
        
        var formdata = ""
        print("request url >>>> "+UrlString)
        print("Request Body >>>>>>"+(httpBody == nil ? (parameters == nil ? "" : String(describing: parameters!)) : httpBody!))
        var HttpBodyString = httpBody == nil ? "" : httpBody!
        
        
        if (httpBodyData == nil)
        {
            if(hTTPMethod == .post){
                var contenttype = "application/json"
                
                if let params = parameters
                {
                    for param in params
                    {
                        formdata += "\(param.0)=\(param.1)&"
                    }
                    formdata = String(formdata.characters.dropLast())
                    
                    contenttype = "application/x-www-form-urlencoded"
                    HttpBodyString = formdata
                }
                
                request.setValue(contenttype, forHTTPHeaderField: "Content-Type")
            }
            else if (parameters != nil) // get
            {
                
               
       
            }
            
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            let data = HttpBodyString.data(using: String.Encoding.utf8)
            
            request.httpBody = data
        }
        else{
            request.httpBody = httpBodyData as Data?
        }
        
        
        var webservices : DataRequest?
        
        // if (responseType == .StringJson)
        //   {
        if (parameters != nil) // get
        {
//            Alamofire.request(UrlString, parameters: parameters,headers:).responseString
//                { response in
//                    
//                    print("Network code for StringJson  ..... \(response.response?.statusCode)")
//                    //   print("network code ..... \(webservices)")
//                    if (responseType == .StringJson)
//                    {
//                        callbackString!(response)
//                    }
//                    else //Dictionary
//                    {
//                        //                    if(response.result.isSuccess)
//                        //                    {
//                        //                        callbackDictionary!(JSON:JSON.parse(response.result.value!), NSError:  response.result.error)
//                        //                    }
//                        //                    else
//                        //                    {
//                        //                        callbackDictionary!(JSON: nil, NSError:  response.result.error)
//                        //                    }
//                    }
//            }
        }
        else
        {
            webservices = Alamofire.request(request).responseString
            { response in
                
                print("Network code for StringJson  ..... \(response.response?.statusCode)")
                //   print("network code ..... \(webservices)")
                if (responseType == .StringJson)
                {
                    callbackString!(response)
                }
                else //Dictionary
                {
                    if(response.result.isSuccess)
                    {
//                        var FinalDictionaryString = response.result.value!
//                                FinalDictionaryString = FinalDictionaryString.replacingOccurrences(of: "\\n", with: "")
//                                  FinalDictionaryString = FinalDictionaryString.replacingOccurrences(of: "\\", with: "")
                        
                        callbackDictionary!(JSON.init(parseJSON: response.result.value!), response.result.error)
                    }
                    else
                    {
                        callbackDictionary!(JSON.null, response.result.error)
                    }
                }
            }
        }
        
        
    }
    
    internal static func DictionaryToJSON(InjectedDictionary : NSDictionary) ->  String
    {
        var FinalDictionaryString = ""

        let data = try! JSONSerialization.data(withJSONObject: InjectedDictionary, options: [])
        FinalDictionaryString = (NSString(data: data, encoding: String.Encoding.utf8.rawValue) as? String)!
        //        FinalDictionaryString = FinalDictionaryString.stringByReplacingOccurrencesOfString("\\n", withString: "")
        //          FinalDictionaryString = FinalDictionaryString.stringByReplacingOccurrencesOfString("\\", withString: "")
        print("--converted jason result >>> "+FinalDictionaryString)
        
        return FinalDictionaryString
    }
    
}
