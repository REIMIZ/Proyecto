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

    @IBOutlet weak var ProductView: UITableView!
    
    let Productos = ["Genshin Impact, Peluche Hu Tao", "Halo, Funko Pop!, Master Chief", "League of Legends, Figura, Ahri", "South Park, Muñecos Decorativos", "Kanojo Okarishimasu, Mizuhara Chizuru, Nendroid", "Evangelion, Peluche, Rei Chiquita", "Overwatch, D.Va, Nendroid", "Fire Emblem, Figura, Lucina", "Shrek, Almohada, Genji", "RWBY, Ruby Rose, Nendroid"]
    let Precios = ["$530", "$300", "$3000", "$540", "$800", "$450", "$750", "$2000", "$380", "$850"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductView.delegate = self
        ProductView.dataSource = self
        

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

extension PrincipalViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Productos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProductView.dequeueReusableCell(withIdentifier: "celda") as! CustomCell
        let Proc = Productos[indexPath.row]
        let price = Precios[indexPath.row]
        cell.productImg.image = UIImage(named: Proc)
        cell.namelbl.text = Proc
        cell.preciolbl.text = price
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detallazos") as? DetallesViewController {
            vc.img = UIImage(named: Productos[indexPath.row])!
            vc.neim = Productos[indexPath.row]
            vc.presio = Precios[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detalles" {
                   let objEditarC = segue.destination as! DetallesViewController
                   
               }
    }
    
    
}
