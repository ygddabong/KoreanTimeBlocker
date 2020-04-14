//
//  ViewController.swift
//  KoreanTimeBlocker
//
//  Created by 송용규 on 06/04/2020.
//  Copyright © 2020 송용규. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit
import CoreLocation


class ViewController: UIViewController ,CLLocationManagerDelegate{
    var locationManager: CLLocationManager!
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var placesClient: GMSPlacesClient!
    
    var startingPlace = ""
    var endingPlace = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPlace()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        searchMaps()
        


    }
    
    func currentPlace(){
        placesClient = GMSPlacesClient.shared()
        placesClient.currentPlace(callback: { (placeLikelihoodList, error) -> Void in
          if let error = error {
            print("Current Place error: \(error.localizedDescription)")
            return
          }
            
          if let placeLikelihoodList = placeLikelihoodList {
            guard let place = placeLikelihoodList.likelihoods.first?.place else {return}
            print("CurrentPlace : \(place.name ?? "")")
            self.startingPlace = place.name!
            let camera = GMSCameraPosition.camera(withLatitude:             place.coordinate.latitude
                , longitude:place.coordinate.longitude, zoom: 16.0)
             let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
             self.view.addSubview(mapView)
             
             // Creates a marker in the center of the map.
             let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: place.coordinate.latitude
                , longitude:place.coordinate.longitude)
             marker.map = mapView
          }
        })
    }
    
    
    func searchMaps(){
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController

        // Put the search bar in the navigation bar.
        searchController?.searchBar.sizeToFit()
        navigationItem.titleView = searchController?.searchBar

        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true

        // Prevent the navigation bar from being hidden when searching.
        searchController?.hidesNavigationBarDuringPresentation = false
    }
    
}

// Handle the user's selection.
extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didAutocompleteWith place: GMSPlace) {
    searchController?.isActive = false
    // Do something with the selected place.
    print("didSelectPlaceName: \(place.name ?? "")")
    self.endingPlace = place.name!

  }

  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}
