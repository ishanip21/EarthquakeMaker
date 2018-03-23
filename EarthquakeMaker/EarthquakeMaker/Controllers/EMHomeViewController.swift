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

class EMHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {
    
    enum SelectedMenuType {
        case Map
        case List
    }

    @IBOutlet weak var earthquakeTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var menuView: UIView!
    
    var timer: Timer!
    var selectedMenuType = SelectedMenuType.Map
    var refreshControl: UIRefreshControl!
    var earthquakes: Earthquake?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Earthquakes"
        earthquakeTableView.tableFooterView = UIView()
        
        //call the API
        callApi()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        //Changed the tableview cell according to the selected menu. default it is set to Map view
        if sender.selectedSegmentIndex == 0 {
            selectedMenuType = .Map
        } else {
            selectedMenuType = .List
            
            if refreshControl == nil {
                refreshControl = UIRefreshControl()
                refreshControl.tintColor = UIColor.blue
                self.earthquakeTableView.addSubview(refreshControl)
            }
            
        }
        earthquakeTableView.reloadData()
        print("index \(sender.selectedSegmentIndex)")
    }
    
    //MARK: - Custom methods
    //Call the API and JSON response converted into Earthquake object
    private func callApi() {
        
        let URL = Constants.init().apiUrl!
        Alamofire.request(URL).responseObject { (response: DataResponse<Earthquake>) in
            
            self.earthquakes = response.result.value
            
            if self.earthquakes!.features!.count > 0 {
                self.earthquakeTableView.reloadData()
            }
        }
    }
    
    func getDate(date: Int64!) -> String {
        
        let timeInterval    = Double(date)
        let earthquakeDate  = Date(timeIntervalSince1970: timeInterval / 1000.0)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        return dateFormatter.string(from: earthquakeDate)
    }
    
    func refreshing() {
        timer = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(endOfRefeshing), userInfo: nil, repeats: true)
    }
    
    @objc func endOfRefeshing() {
        
        refreshControl.endRefreshing()
        
        timer.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if refreshControl.isRefreshing {
            //Tableview refreshing clear data and reload tabelView
            self.earthquakes?.features?.removeAll()
            self.earthquakeTableView.reloadData()
            callApi()
            refreshing()
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
            let cell:MapCell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as! MapCell
            
            if self.earthquakes != nil && self.earthquakes!.features!.count > 0 {
                
                for feature: Feature! in self.earthquakes!.features! {
                    let annotation = MKPointAnnotation()
                    annotation.title        = feature?.propertie?.place!
                    annotation.subtitle     = getDate(date: feature!.propertie!.time)
                    annotation.coordinate   = CLLocationCoordinate2D(latitude: feature!.geometry!.coordinates![1], longitude: feature!.geometry!.coordinates![0])
                    cell.mapView.addAnnotation(annotation)
                }
                
                cell.mapView.showAnnotations(cell.mapView.annotations, animated: true)
            }
            
            return cell;
            
        } else {
            let cell:EarthquakeCell = tableView.dequeueReusableCell(withIdentifier: "EarthquakeCell", for: indexPath) as! EarthquakeCell
            
            let feature: Feature!   = self.earthquakes!.features![indexPath.row];
            cell.placeLabel.text    = feature!.propertie!.place
            cell.dateLabel.text     = getDate(date: feature!.propertie!.time)
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedMenuType == .Map {
            return view.frame.size.height - 60
        } else {
            return 60
        }
    }
    
    
     // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MapViewController" {
            if let indexPath = self.earthquakeTableView.indexPathForSelectedRow {
                let controller = segue.destination as! EMMapViewController
                controller.feature = self.earthquakes?.features?[indexPath.row]
            }
        }
    }
}
