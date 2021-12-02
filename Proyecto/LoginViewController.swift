//
//  LoginViewController.swift
//  Proyecto
//
//  Created by mac16 on 01/12/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var CorreoTF: UITextField!
    @IBOutlet weak var ContraTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard

              if let correo = defaults.value(forKey: "correo") as? String
              {
                  performSegue(withIdentifier: "LoginInicio", sender: self)
              }

         
    }
    func alertamsg(msj: String){
          let alerta = UIAlertController(title: "ERROR", message: msj, preferredStyle: .alert)
          alerta.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: nil))
          present(alerta, animated: true, completion: nil)
      }
    
    @IBAction func LoginBtn(_ sender: UIButton) {
        if let email = CorreoTF.text, let password = ContraTF.text{
                    Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                        if let e = error{
                            print(e.localizedDescription)
                            self?.alertamsg(msj: "Error al iniciar sesion")
                        }else{
                            self?.performSegue(withIdentifier: "LoginInicio", sender: self)
                        }
                        
                    }
        }
    }
}
