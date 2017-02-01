//
//  M_Trip.swift
//  CarTrackingTest
//
//  Created by M-Hashem on 1/31/17.
//  Copyright © 2017 M-Hashem. All rights reserved.
//

import Foundation
import EVReflection

class M_Trip:EVObject
{
    var TransferID : String? = nil
    var FromAddress : String? = nil
    var FromLat : String? = nil
    var FromLong : String? = nil
    var ToAddress : String? = nil
    var ToLong : String? = nil
    var ToLat : String? = nil
}

class M_Trip_Response:EVObject
{
    var status : String? = nil
    var message : [M_Trip]? = nil
    
}
