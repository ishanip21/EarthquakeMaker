//
//  EMHomeViewController.swift
//  EarthquakeMaker
//
//  Created by Ishan on 3/21/18.
//  Copyright © 2018 Ishan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireObjectMapper
import MapKit
import CoreLocation

class EMHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum SelectedMenuType {
        case Map
        case List
    }

    @IBOutlet weak var earthquakeTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var selectedMenuType = SelectedMenuType.Map
    var earthquakes: Earthquake?
    var selectedIndex: Int! = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Earthquakes"
        
        earthquakeTableView.tableFooterView = UIView()
        
        callApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedMenuType = .Map
        } else {
            selectedMenuType = .List
        }
        earthquakeTableView.reloadData()
        print("index \(sender.selectedSegmentIndex)")
    }
    
    private func callApi() {
        let URL = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"
        Alamofire.request(URL).responseObject { (response: DataResponse<Earthquake>) in
            
            self.earthquakes = response.result.value
            print(self.earthquakes?.type)
            
            if self.earthquakes!.features!.count > 0 {
                self.earthquakeTableView.reloadData()
            }
        }
    }

    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedMenuType == .Map {
            return 1
        } else {
            return self.earthquakes!.features!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedMenuType == .Map {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as? MapCell  else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            }
    
            if self.earthquakes != nil && self.earthquakes!.features!.count > 0 {
                for feature: Feature! in self.earthquakes!.features! {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: feature!.geometry!.coordinates![0] as! Double, longitude: feature!.geometry!.coordinates![0] as! Double)
                    cell.mapView.addAnnotation(annotation)
                }
            }
            return cell;
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EarthquakeCell", for: indexPath) as? EarthquakeCell  else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            }
            
            let feature: Feature! = self.earthquakes!.features![indexPath.row];
            cell.placeLabel.text    = feature!.propertie!.place
            //cell.dateLabel.text     = NSDate(timeIntervalSince1970: feature!.propertie!.time!)
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedMenuType == .Map {
            return view.frame.size.height - 60
        } else {
            return 60
        }
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
     }
    
    
}
