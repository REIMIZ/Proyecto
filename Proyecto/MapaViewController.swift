//
//  MapaViewController.swift
//  Proyecto
//
//  Created by mac16 on 07/12/21.
//

import UIKit
import MapKit

class MapaViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var manager = CLLocationManager()
        var latitud2: CLLocationDegrees!
        var longitud2: CLLocationDegrees!
    
    @IBOutlet weak var Map: MKMapView!
    
    var recibedir: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.delegate = self
             //  manager.requestWhenInUseAuthorization()
               manager.desiredAccuracy = kCLLocationAccuracyBest
               manager.startUpdatingLocation()
               Map.delegate = self
               
               
               self.navigationItem.setHidesBackButton(true, animated: true)
               
               let alerta = UIAlertController(title: "Ubicacion", message: "Tu pedido fue hecho con exito, entregas de 5 a 7 dias ", preferredStyle: .alert )
                      let accionAceptar = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
           
               alerta.addAction(accionAceptar)
               present(alerta, animated: true, completion: nil)
        
               TrazarRuta()
    }
    

    @IBAction func RegresarBtn(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func preTrazarRuta(coordenadasDestino:CLLocationCoordinate2D)
            {
                if let LAT = latitud2, let LON = longitud2
                {
                    let coordenadasOrigen = CLLocationCoordinate2DMake(LAT, LON)
                    
                    let origenPlaceMK = MKPlacemark(coordinate: coordenadasOrigen)
                    let destinoPlaceMK = MKPlacemark(coordinate: coordenadasDestino)
                    
                   
                    let origenItem = MKMapItem(placemark: origenPlaceMK)
                    let destinoItem = MKMapItem(placemark: destinoPlaceMK)
                    
                    
                    let solicitudDestino = MKDirections.Request()
                    solicitudDestino.source = origenItem
                    solicitudDestino.destination = destinoItem
                    
                    
                    solicitudDestino.transportType = .automobile
                    solicitudDestino.requestsAlternateRoutes = true
                    
                    let direcciones = MKDirections(request: solicitudDestino)
                    direcciones.calculate { (respuesta, error) in
                        
                        guard let respuestaSegura = respuesta else {
                            if let error = error
                            {
                                print("Error al calcular la ruta: \(error.localizedDescription)")
                            }
                            return
                        }
                        print(respuestaSegura.routes.count)
                        let ruta = respuestaSegura.routes[0]
                        
                        
                        self.Map.addOverlay(ruta.polyline)
                        self.Map.setVisibleMapRect(ruta.polyline.boundingMapRect, animated: true)
                    }
                }
            }
            
            func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
                let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
                render.strokeColor = .orange
                return render
            }
            
            
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                
            }
            
            func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                
            }
            
            
            func TrazarRuta()
            {
                if let direccion = recibedir
                {
                    let geocoder = CLGeocoder()
                    
                    
                    let overlays = Map.overlays
                    let anotaciones = Map.annotations
                    
                  Map.removeOverlays(overlays)
                   Map.removeAnnotations(anotaciones)
                    
                    geocoder.geocodeAddressString(direccion) { (places: [CLPlacemark]?, error:Error?) in
                        
                        
                        guard let ruta = places?.first?.location else { return }
                        
                        if error == nil
                        {
                           
                            let place = places?.first
                            print("Lugar: \(places!)")
                            
                           
                            let anotacion = MKPointAnnotation()
                            anotacion.coordinate = (place?.location?.coordinate)!
                            
                          
                            anotacion.title = ""
                            
                            let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                            let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                            
                            self.Map.setRegion(region, animated: true)
                            self.Map.addAnnotation(anotacion)
                            self.Map.selectAnnotation(anotacion, animated: true)
                            
                            
                            self.preTrazarRuta(coordenadasDestino: ruta.coordinate)
                            self.Map.showsUserLocation = true
                            
                            
                        } else {
                            print("Ubicación no encontrada")
                        }
                    }
                    
                }
            }
        

    
    
}
