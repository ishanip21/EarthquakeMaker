//
//  EMMapViewController.swift
//  EarthquakeMaker
//
//  Created by Ishan on 3/22/18.
//  Copyright © 2018 Ishan. All rights reserved.
//

import UIKit
import MapKit

class EMMapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var feature: Feature?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = feature?.propertie?.place!
        self.navigationController?.navigationBar.backItem?.title = " "
        
        mapView.mapType         = .standard
        mapView.isZoomEnabled   = true
        mapView.isScrollEnabled = true
        
        let annotation          = MKPointAnnotation()
        annotation.title        = feature?.propertie?.place!
        annotation.coordinate   = CLLocationCoordinate2D(latitude: feature!.geometry!.coordinates![1],
                                                         longitude: feature!.geometry!.coordinates![0])
        mapView.addAnnotation(annotation)
        
        let center = CLLocationCoordinate2D(latitude: feature!.geometry!.coordinates![1],
                                            longitude: feature!.geometry!.coordinates![0])
        let region = MKCoordinateRegion(center: center,
                                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        mapView.setRegion(region, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
