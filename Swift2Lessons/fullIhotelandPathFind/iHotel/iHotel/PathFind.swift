//
//  PathFind.m
//  MapKitCoreLocation
//
//  Created by Cuong Trinh on 10/1/15.
//  Copyright © 2015 Cuong Trinh. All rights reserved.
//

import MapKit
import AddressBookUI
import UIKit
class PathFind: BaseController, MKMapViewDelegate, UITextFieldDelegate {
    var addressString: NSString?
    var overlay: MKOverlay?
    var foundPlace: CLPlacemark?
    var fromLocation: CLLocation?
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var direction: MKDirections?
    var geoCoder: CLGeocoder?
    var foundIndicator: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = .None
        self.navigationController!.navigationBar.shadowImage = nil
        self.navigationController!.navigationBar.translucent = false
        


        
//        self.address.clearButtonMode = .Always
        //    self.address.delegate = self;
        self.mapView.delegate = self
        self.foundIndicator = UIImageView(image: UIImage(named: "red"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.foundIndicator!)
        self.fromLocation = CLLocation(latitude: 21.01484, longitude: 105.84660)
        self.updateRegion(10.0)
        let fromPin: MKPointAnnotation = MKPointAnnotation()
        fromPin.coordinate = fromLocation!.coordinate
        fromPin.title = "TechMaster"
        self.mapView.addAnnotation(fromPin)
        self.geoCoder = CLGeocoder()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.geoCoder?.geocodeAddressString(self.addressString as! String, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                self.updateFoundIndicator(false)
            }
            else {
                self.foundPlace = placemarks!.first
                let foundPin: MKPointAnnotation = MKPointAnnotation()
                foundPin.coordinate = self.foundPlace!.location!.coordinate
                foundPin.title = self.foundPlace!.description
                self.mapView.addAnnotation(foundPin)
                self.updateFoundIndicator(true)
                let toPlace: MKPlacemark = MKPlacemark(placemark: self.foundPlace!)
                self.routePath(MKPlacemark(coordinate: self.fromLocation!.coordinate, addressDictionary: nil), toLocation: toPlace)
            }
            
        })
    }
    
    func updateRegion(scale: Float) {
        let size: CGSize = self.mapView.bounds.size
        let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(fromLocation!.coordinate, Double(Float(size.height) * scale), Double(Float(size.width) * scale))
        self.mapView.setRegion(region, animated: true)
    }
    
    func updateFoundIndicator(found: Bool) {
        if found {
            self.foundIndicator!.image = UIImage(named: "white")
        }
        else {
            self.foundIndicator!.image = UIImage(named: "red")
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
            self.geoCoder?.geocodeAddressString(self.addressString as! String, completionHandler: { (placemarks, error) -> Void in
                if (error != nil) {
                    self.updateFoundIndicator(false)
                }
                else {
                    self.foundPlace = placemarks!.first
                    let foundPin: MKPointAnnotation = MKPointAnnotation()
                    foundPin.coordinate = self.foundPlace!.location!.coordinate
                    foundPin.title = self.foundPlace!.description
                    self.mapView.addAnnotation(foundPin)
                    self.updateFoundIndicator(true)
                    let toPlace: MKPlacemark = MKPlacemark(placemark: self.foundPlace!)
                    self.routePath(MKPlacemark(coordinate: self.fromLocation!.coordinate, addressDictionary: nil), toLocation: toPlace)
                }
                
            })
        }
        return true
    }
    
    func routePath(fromPlace: MKPlacemark, toLocation toPlace: MKPlacemark) {
        let request: MKDirectionsRequest = MKDirectionsRequest()
        let fromMapItem: MKMapItem = MKMapItem(placemark: fromPlace)
        request.source = fromMapItem
        let toMapItem: MKMapItem = MKMapItem(placemark: toPlace)
        request.destination = toMapItem
        self.direction = MKDirections(request: request)
        self.direction!.calculateDirectionsWithCompletionHandler { (response, error) -> Void in
            if (error != nil) {
                NSLog("Error %@", error!.localizedDescription)
            }
            else {
                self.mapSetRegion(fromPlace.coordinate, and: toPlace.coordinate)
                self.showRoute(response!)
            }
        }
    }
    
    func mapSetRegion(fromPoint: CLLocationCoordinate2D, and toPoint: CLLocationCoordinate2D) {
        let centerPoint: CLLocationCoordinate2D = CLLocationCoordinate2DMake((fromPoint.latitude + toPoint.latitude) / 2.0, (fromPoint.longitude + toPoint.longitude) / 2.0)
        let latitudeDelta: Double = abs(fromPoint.latitude - toPoint.latitude) * 1.5
        let longtitudeDelta: Double = abs(fromPoint.longitude - toPoint.longitude) * 1.5
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(centerPoint, span)
        self.mapView.setRegion(region, animated: true)
    }
    
    func showRoute(response: MKDirectionsResponse) {
//        var fromAnnotation: LocationAnnotation = LocationAnnotation(coordinate: fromLocation!.coordinate, andTitle: "From", andSubTitle: "TechMaster")
        let fromAnnotation: LocationAnnotation = LocationAnnotation(coordinate: fromLocation!.coordinate, title: "From", subTitle: "TechMaster")
        let toAnnotation: LocationAnnotation = LocationAnnotation(coordinate: foundPlace!.location!.coordinate, title: "To", subTitle: ABCreateStringWithAddressDictionary(foundPlace!.addressDictionary!, false))
        self.mapView.addAnnotation(fromAnnotation)
        self.mapView.addAnnotation(toAnnotation)
        for route: MKRoute in response.routes {
            /*
            MKPolyline * polyLine = route.polyline;
            
            for (int i = 0; i < polyLine.pointCount; i++) {
            MKMapPoint point = polyLine.points[i];
            NSLog(@"x= %f, y=%f", point.x, point.y);
            }*/
            //[self.mapView removeOverlay:_overlay];
            self.overlay = route.polyline
            self.mapView.addOverlay(overlay!, level: .AboveRoads)
            for step: MKRouteStep in route.steps {
                NSLog("%@", step.instructions)
            }
        }
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blueColor()
        renderer.lineWidth = 5.0
        return renderer
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier: String = "FoundLocation"
        let pinView: MKPinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        pinView.pinColor = .Green
        return pinView
    }

}
