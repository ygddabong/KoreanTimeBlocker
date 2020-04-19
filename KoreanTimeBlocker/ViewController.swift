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
    var mapView: GMSMapView!
    
    var destinationPlaceName = ""
    
    var startCoordinate:CLLocationCoordinate2D?
    var destCoordinate:CLLocationCoordinate2D?
    
    
    
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
                self.startCoordinate = place.coordinate
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
    
    func mapThis(destinationCord : CLLocationCoordinate2D) {
        
        let souceCordinate = (locationManager.location?.coordinate)!
        let soucePlaceMark = MKPlacemark(coordinate: souceCordinate)
        let destPlaceMark = MKPlacemark(coordinate: destinationCord)
        let sourceItem = MKMapItem(placemark: soucePlaceMark)
        let destItem = MKMapItem(placemark: destPlaceMark)
        
        let destinationRequest = MKDirections.Request()
        destinationRequest.source = sourceItem
        destinationRequest.destination = destItem
        //destinationRequest.transportType = .automobile
        destinationRequest.transportType = .walking
        destinationRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: destinationRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let err = error {
                    print("Something is wrong :\(err.localizedDescription)")
                }
                return
            }
            let route = response.routes[0]
            let resultTime = "\(Int(ceil((route.expectedTravelTime)/60)))"
            print("resultTime: \(resultTime)")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlarmSettingViewController") as? AlarmSettingViewController
            vc?.responsePlace = self.destinationPlaceName
            vc?.responseTime = resultTime
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}

// Handle the user's selection.
extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("didSelectPlaceName: \(place.name ?? "")")
        self.destinationPlaceName = place.name ?? ""
        self.destCoordinate = place.coordinate
        self.mapThis(destinationCord: destCoordinate!)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
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
