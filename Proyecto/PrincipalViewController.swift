//
//  PrincipalViewController.swift
//  Proyecto
//
//  Created by mac16 on 02/12/21.
//

import UIKit
import Firebase
import FirebaseAuth

class PrincipalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: true)
      
                if let email = Auth.auth().currentUser?.email
                {
                    let defaults = UserDefaults.standard
                    defaults.set(email,forKey: "correo")
                    defaults.synchronize()
                }
        
    }
    
    @IBAction func cerrarBtn(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
                
                //Eliminamos los datos de inicio de sesión que habíamos guardado
                let defaults = UserDefaults.standard
                defaults.removeObject(forKey: "correo")
                defaults.synchronize()
                
                print("Cierre de sesión realizado correctamente")
                navigationController?.popToRootViewController(animated: true)
            } catch let error as NSError {
                print("Error signing out: \(error.localizedDescription)")
            }
    }
    
}
