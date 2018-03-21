//
//  EMHomeViewController.swift
//  EarthquakeMaker
//
//  Created by Ishan on 3/21/18.
//  Copyright © 2018 Ishan. All rights reserved.
//

import UIKit

class EMHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum SelectedMenuType {
        case Map
        case List
    }

    @IBOutlet weak var earthquakeTableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var selectedMenuType = SelectedMenuType.Map
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Earthquakes"
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
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedMenuType == .Map {
            return 1
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedMenuType == .Map {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EarthQuakeCell", for: indexPath) as? UITableViewCell  else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            }
            return cell;
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MapCell", for: indexPath) as? UITableViewCell  else {
                fatalError("The dequeued cell is not an instance of MealTableViewCell.")
            }
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedMenuType == .Map {
            return 60
        } else {
            return view.frame.size.height - 60
        }
        
    }
    
}
