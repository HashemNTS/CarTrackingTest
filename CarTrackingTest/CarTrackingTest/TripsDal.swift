//
//  TripsDal.swift
//  CarTrackingTest
//
//  Created by M-Hashem on 1/31/17.
//  Copyright © 2017 M-Hashem. All rights reserved.
//

import Foundation
import SwiftyJSON
protocol ITripDal
{
    func GetAllTrips(callback:@escaping (_ sucess:Bool,_ message:String,_ TripsData:[M_Trip]?)->())
}

class TripDal:ITripDal
{
    internal func GetAllTrips(callback:@escaping (_ sucess:Bool,_ message:String,_ TripsData:[M_Trip]?) -> ())
    {
        let RequestParameters : NSDictionary =
            [
                "un" : VcLogin.UserName,
                "up" : VcLogin.Password,
                "name":"test",
                "password":"123"
                ]
        
        let RequestParametersString =  NetworkHelper.DictionaryToJSON(InjectedDictionary: RequestParameters)
   
//        NetworkHelper.RequestHelper(domainusrl: nil, service: WebServiceMethods.Trips.rawValue, hTTPMethod: .post, parameters: nil, httpBody: RequestParametersString, httpBodyData: nil, responseType: .DictionaryJson, callbackString: nil,
//                                    callbackDictionary: { (response:(json:JSON, error:Error?)) in
//                                        var sucess = false;
//                                        var message = "unhandeled Error";
//                                        var tripsData:[M_Trip]?
//
//                                        if let Error = response.error
//                                        {
//                                            message = Error.localizedDescription
//                                        }
//                                        else
//                                        {
//                                            let result_status = response.json["status"].stringValue //M_Response(json: response.result.value)
//                                            let result_message = response.json["message"].stringValue
//                                            
//                                            if (result_status == "success")
//                                            {
//                                                tripsData = [M_Trip](json:message)
//                                                sucess = true
//                                            }
//                                            else
//                                            {
//                                                message = result_message
//                                            }
//                                        }
//                                        callback(sucess,message,tripsData)
//                                        
//        }
//        
//        )
        
        
        NetworkHelper.RequestHelper(domainusrl: nil, service: WebServiceMethods.Trips.rawValue, hTTPMethod: .post, parameters: nil, httpBody: RequestParametersString,httpBodyData: nil,
                                    callbackString: { (response) in
                                        var sucess = false;
                                        var message = "unhandeled Error";
                                        var tripsData:[M_Trip]?
                                        
                                        if let Error = response.error
                                        {
                                            message = Error.localizedDescription
                                        }
                                        else
                                        {
                                            let result = M_Trip_Response(json: response.result.value)
                                            
                                            if (result.status == "success")
                                            {
                                                tripsData = result.message
                                                sucess = true
                                            }
                                            else
                                            {
                                                message = "fail"//result.message!
                                            }
                                        }
                                        callback(sucess,message,tripsData)
                                        
        },callbackDictionary:nil)

        
    }

    
}
