//
//  TcTrip.swift
//  CarTrackingTest
//
//  Created by M-Hashem on 1/31/17.
//  Copyright © 2017 M-Hashem. All rights reserved.
//

import UIKit

class TcTrip: UITableViewCell
{
    @IBOutlet weak var FromAdress: UILabel!
    @IBOutlet weak var ToAdress: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(tripdata:M_Trip)
    {
        FromAdress.text = tripdata.FromAddress
        ToAdress.text = tripdata.ToAddress
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
