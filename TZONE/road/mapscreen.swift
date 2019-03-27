//
//  ViewController.swift
//  map
//
//  Created by MOHAB on 3/16/19.
//  Copyright © 2019 MOHAB. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class mapscreen: UIViewController  , UISearchBarDelegate {
    
    
    @IBAction func searchbutton(_ sender: Any) {
        
        let searchcontroller = UISearchController(searchResultsController: nil)
        searchcontroller.searchBar.delegate = self
        present(searchcontroller , animated:  true , completion: nil)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        // ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        // activity indicator
        
        
        let activityindicator = UIActivityIndicatorView()
        activityindicator.activityIndicatorViewStyle = UIActivityIndicatorView.Style.gray
        activityindicator.center = self.view.center
        activityindicator.hidesWhenStopped = true
        activityindicator.startAnimating()
        
        self.view.addSubview(activityindicator)
        
        
        
        // hide search bar
        
        searchBar.resignFirstResponder()
        
        dismiss(animated: true, completion: nil)
        
        
        // create the search request
        
        
        let searchrequest = MKLocalSearch.Request()
        searchrequest.naturalLanguageQuery = searchBar.text
        
        let activesearch = MKLocalSearch(request: searchrequest)
        
        activesearch.start { (response, error) in
            
            activityindicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil {
                
                print("ERROR")
                
            }else {
                
                // remove annotation
                
                let annotations = self.mapview.annotations
                self.mapview.removeAnnotations(annotations)
                
                
                // getting data
                
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                // create  annotation
                
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
                self.mapview.addAnnotation(annotation)
                
                // zooming in an annotation
                
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapview.setRegion(region, animated: true)
                
                
            }
        }
        
        
        
    }
    
    
    @IBOutlet weak var imageGetMyLocation: UIImageView!
    @IBOutlet weak var adresslabel: UILabel!
    
    @IBOutlet weak var yourlocation: UITextField!
    @IBOutlet weak var mapview: MKMapView!
      var address = [String]()
    let locationmanager = CLLocationManager()
    
    let regioninmeter : Double = 10000
    var previouslocation : CLLocation?
    
    var directionsarray : [MKDirections] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
               setLocationName()
        checklocationservices()
//        print(address[0])
 
    }
    
    
    func setuplocationmanager(){
        
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        
     
    }
    
    
//    func centerMapOnUSerLocation (){
//        guard let coordinate = locationManger.location?.coordinate else{
//            return
//        }
//
//        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionReduis*2.0, longitudinalMeters: regionReduis*2.0)
//        mapViewData.setRegion(coordinateRegion, animated: true)
//    }
    
    func centerviewonuserlocation(){
        guard let coordinate = locationmanager.location?.coordinate else{
            return
        }
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regioninmeter, regioninmeter)
        mapview.setRegion(coordinateRegion, animated: true)
        
    }
    
    
    
    
    
    
    func checklocationservices() {
       
        
        if CLLocationManager.locationServicesEnabled(){
            
            // setup our locationmanager
            setuplocationmanager()
            checklocationAuthorization()
           
            
        }
        else
        {
            
        }
    }

    func checklocationAuthorization()  {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            
            // do map stuff
            starttakinguserlocation()
            break
        case .denied :
            break
        case .notDetermined :
            
            locationmanager.requestWhenInUseAuthorization()
            
           
        case .restricted :
            
           // show an alert letting them know whatis up
            break
        case .authorizedAlways :
            break
        }
    }
    
    
    func starttakinguserlocation(){
        
        
        mapview.showsUserLocation = true
        centerviewonuserlocation()
        locationmanager.startUpdatingLocation()
        previouslocation = getcenteroflocation(for: mapview)
        
        
        
        
    }
    
    func setLocationName(){
        let Tapregognizer = UITapGestureRecognizer(target: self, action: #selector(getNameOfLocation))
        Tapregognizer.numberOfTapsRequired = 1
        self.imageGetMyLocation.addGestureRecognizer(Tapregognizer)
        self.imageGetMyLocation.isUserInteractionEnabled = true
        
       
    }
    @objc func getNameOfLocation(){
       // self.address.removeAll()
        if let coordinate = locationmanager.location?.coordinate{
            let long = coordinate.longitude
            let lat = coordinate.latitude
            let gecoder = CLGeocoder()
            let location = CLLocation(latitude: lat, longitude: long)
            gecoder.reverseGeocodeLocation(location) { (placesMark, error) in
                guard let placeMark = placesMark?.first else { return }
                
                // Location name
                if let locationName = placeMark.location {
                    print(locationName)
                }
                // Street address
                if let street = placeMark.thoroughfare {
                    print("mohab\(street)")
                    self.address.append(street)
                    print(street)
                }
                // City
                if let city = placeMark.subAdministrativeArea {
                    self.address.append(city)
                    
                    print(city)
                }
                // Zip code
                if let zip = placeMark.isoCountryCode {
                    print(zip)
                }
                // Country
                if let country = placeMark.country {
                    self.address.append(country)
                }
                
                    self.yourlocation.text = self.address.joined(separator: "/")
                    print(self.address[0])
                
                
                
            }}}
    
    
    func getcenteroflocation(for mapview : MKMapView)-> CLLocation {
        
        let latitude = mapview.centerCoordinate.latitude
        let longitude = mapview.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
    func getDirections(){
        
        
        guard let location = locationmanager.location?.coordinate else {return}
        
        
        let request = createdirectionrequest(from: location)
        
        let directions = MKDirections(request: request)
        resetmapview(withnew: directions)
        
        directions.calculate { [unowned self](response, error) in
            guard let response = response else{return}
            
            for route in response.routes {
                let step = route.steps
                self.mapview.add(route.polyline)
                self.mapview.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                
                
            }
        }
        
        
    }
    
    func createdirectionrequest(from coordinate : CLLocationCoordinate2D)-> MKDirections.Request{
        
        
        let destinationcoordinate             = getcenteroflocation(for: mapview).coordinate
        let startinglocation                  = MKPlacemark(coordinate: coordinate)
        let destination                        = MKPlacemark(coordinate: destinationcoordinate)
        
        
        let request                            = MKDirections.Request()
        request.source                          = MKMapItem(placemark: startinglocation)
        request.destination                     = MKMapItem(placemark: destination)
        request.transportType                    = .automobile
        request.requestsAlternateRoutes          = true
        
        return request
        
        
    }
    
    func resetmapview(withnew directions : MKDirections){
        
        mapview.removeOverlays(mapview.overlays)
        directionsarray.append(directions)
       let _ = directionsarray.map {$0.cancel()}
        
    }
    

    @IBAction func confirmpickupbutton(_ sender: Any) {
        getDirections()
    }
}

extension  mapscreen : CLLocationManagerDelegate {
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//      //  we will back
//        guard let location = locations.last else{return}
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let Region = MKCoordinateRegion.init(center: center, latitudinalMeters: regioninmeter, longitudinalMeters: regioninmeter)
//        mapview.setRegion(Region, animated: true)
//
//
//    }
//
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        //we will back
        
        checklocationAuthorization()
        
        
        
        
    }
    
    
    
}




extension mapscreen : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getcenteroflocation(for: mapView)
        
        let geocoder = CLGeocoder()
        
        guard let previouslocation = self.previouslocation else{return}
        
        guard center.distance(from: previouslocation) > 50 else {return}
        
        self.previouslocation = center
        
        geocoder.cancelGeocode()
        
        geocoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            
            
            guard let self = self else {return}
            
            
            if let _ = error {
                
                
                return
            }
            guard let placemark = placemarks?.first else {return}
            
            let streetnumber = placemark.subThoroughfare ?? ""
            let streetname = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                 self.adresslabel.text = "\(streetnumber)\(streetname)"
            }
           
            
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
}
