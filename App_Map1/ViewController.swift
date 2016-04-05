//
//  ViewController.swift
//  App_Map1
//
//  Created by CICE on 5/4/16.
//  Copyright © 2016 CICE. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

enum MapType : Int{
    case standard = 0
    case satellite = 1
    case hybrid = 2
}

class ViewController: UIViewController {

    //MARK: - IBOUTLET
    @IBOutlet weak var segmentControlType: UISegmentedControl!
    @IBOutlet weak var mapMyMap: MKMapView!
    @IBOutlet weak var labelShowData: UILabel!
    
    var locationManager = CLLocationManager()
    
    //MARK: - IBACTION
    @IBAction func buttonShowLocation(sender: AnyObject) {
        //Fase 1 -> Crear el punto en el mapa (manualmente)
        let latitud : CLLocationDegrees = 40.433667
        let longitud : CLLocationDegrees = -3.676266
        //marcan el zoom y están en función de la orientación de la pantalla
        let latDelta : CLLocationDegrees = 0.005 //escala
        let longDelta : CLLocationDegrees = 0.005
        //agrupamos en la variable que entiende el mapa
        let location : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        let span : MKCoordinateSpan = MKCoordinateSpan (latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        //asignamos al mapa
        mapMyMap.setRegion(region, animated: true)
        //Fase 2 ->Creamos una anotación
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Estamos aquí en clase"
        annotation.subtitle = "HOLA MUNDO"
        mapMyMap.addAnnotation(annotation)
        
    }
    
    @IBAction func cahngedMapType(sender: AnyObject) {
        let mapType = MapType(rawValue: segmentControlType.selectedSegmentIndex)
        
        switch(mapType!){
        case.standard:
            mapMyMap.mapType = MKMapType.Standard
        case.satellite:
            mapMyMap.mapType = MKMapType.Satellite
        case.hybrid:
            mapMyMap.mapType = MKMapType.Hybrid
            break
        }
        
    }
    
    //MARK: - LIFE VIEW CONTROLLER
    override func viewDidLoad() {
        super.viewDidLoad()
        //asignamos nuestro locationManager
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: - CLLocationManagerDelegate
extension ViewController : CLLocationManagerDelegate{
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let userLocation = locations.first!
        let userLocation = locations[0]
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        mapMyMap.setRegion(region, animated: true)
        labelShowData.text = "\(userLocation)"
    }
    
}


