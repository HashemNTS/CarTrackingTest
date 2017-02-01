//
//  VcHome.swift
//  CarTrackingTest
//
//  Created by M-Hashem on 1/31/17.
//  Copyright © 2017 M-Hashem. All rights reserved.
//

import UIKit
import Toast_Swift
import MBProgressHUD

class VcHome: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    @IBOutlet weak var routesTable:UITableView!
    
    var tripsList=[M_Trip]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        routesTable.dataSource = self
        routesTable.delegate = self
        
        navigationItem.title = "Trips"
        routesTable.register(TcTrip.self, forCellReuseIdentifier: "TcTrip")
        routesTable.register(UINib(nibName: "TcTrip",bundle: nil), forCellReuseIdentifier: "TcTrip")
        
        loadData()
        // Do any additional setup after loading the view.
    }
    func loadData()
    {
        let loading = MBProgressHUD.showAdded(to: self.view, animated: true)
        DAL.SharedTripsDal.GetAllTrips { (Sucess, message, tripsData:[M_Trip]?) in
             loading.hide(animated: true)
            if (!Sucess)
            {
                self.view.makeToast(message)
            }
            else
            {
                self.tripsList = tripsData!
                self.routesTable.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  tripsList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TcTrip") as! TcTrip
        cell.setData(tripdata: tripsList[indexPath.row])
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
     let mapView = storyboard?.instantiateViewController(withIdentifier: "VcMap") as! VcMap
        mapView.tripData = tripsList[indexPath.row];
        navigationController?.pushViewController(mapView, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
