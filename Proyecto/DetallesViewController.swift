//
//  DetallesViewController.swift
//  Proyecto
//
//  Created by mac16 on 06/12/21.
//

import UIKit
import MapKit

class DetallesViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var descripcionlbl: UILabel!
    @IBOutlet weak var premiumlbl: UILabel!
    @IBOutlet weak var DirTF: UITextField!
    
    var img = UIImage()
    var neim = ""
    var presio = ""
    var direccion: String?
    
    var manager = CLLocationManager()
        var latitud: CLLocationDegrees!
        var longitud: CLLocationDegrees!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileIMG.image = img
        descripcionlbl.text = neim
        premiumlbl.text = presio
        
        manager.delegate = self
                manager.requestWhenInUseAuthorization()

                manager.desiredAccuracy = kCLLocationAccuracyBest
                manager.startUpdatingLocation()

    }
    

    @IBAction func regresarBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func PedidoBtn(_ sender: UIButton) {
        direccion = DirTF.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "avanzar" {
                let objdestino = segue.destination as! MapaViewController
                objdestino.recibedir = direccion
                objdestino.latitud2 = latitud
                objdestino.longitud2 = longitud
            }
            
        }
        
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
               if let location = locations.first{
                   self.latitud = location.coordinate.latitude
                   self.longitud = location.coordinate.longitude
               }
               
           }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
}
