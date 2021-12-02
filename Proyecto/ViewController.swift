//
//  ViewController.swift
//  Proyecto
//
//  Created by mac16 on 01/12/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var msglabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        msglabel.text = ""
        
        var charIndex = 0.0
        
        let mensajeText = "Bienvenido a nuestra app, inicia sesion o registrate para vivir la experiencia y ver que podemos ofrecerte"
        
        for letra in mensajeText{
            
            print(letra)
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (Timer) in
                self.msglabel.text?.append(letra)
            }
            charIndex += 1
        }
    }


}

