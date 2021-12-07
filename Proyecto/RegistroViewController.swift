//
//  RegistroViewController.swift
//  Proyecto
//
//  Created by mac16 on 01/12/21.
//

import UIKit
import Firebase
import FirebaseAuth

class RegistroViewController: UIViewController {

    @IBOutlet weak var correoTF: UITextField!
    @IBOutlet weak var contraTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func alertamsg(msj: String){
           let alerta = UIAlertController(title: "ERROR", message: msj, preferredStyle: .alert)
           alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
           present(alerta, animated: true, completion: nil)
       }
    @IBAction func RegistrarBtn(_ sender: UIButton) {
        if let email = correoTF.text, let password = contraTF.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                print("Error al crear usuario\(e.localizedDescription)")
                    if e.localizedDescription == "The email address is already in use by another account."{
                        self.alertamsg(msj: "Correo ya en uso")
                    }else if e.localizedDescription == "The email address is badly formatted."{
                        self.alertamsg(msj: "Verifica el formato del email")
                    }else if e.localizedDescription == "The password must be 6 characters long or more"{
                        self.alertamsg(msj: "Error al crear usuario")
                    }
                
                }else{
                        self.performSegue(withIdentifier: "registroInicio", sender: self)
                    }
                
            }
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
   

}
