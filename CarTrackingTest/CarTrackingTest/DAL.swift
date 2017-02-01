//
//  DAL.swift
//  CarTrackingTest
//
//  Created by M-Hashem on 1/31/17.
//  Copyright © 2017 M-Hashem. All rights reserved.
//

import Foundation
class DAL
{
    static let SharedLoginDal:ILoginDal={
        return LoginDal();
    }()
    
    static let SharedTripsDal:ITripDal={
        return TripDal();
    }()
    
}
