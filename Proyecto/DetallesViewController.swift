//
//  DetallesViewController.swift
//  Proyecto
//
//  Created by mac16 on 06/12/21.
//

import UIKit

class DetallesViewController: UIViewController {

    @IBOutlet weak var profileIMG: UIImageView!
    @IBOutlet weak var descripcionlbl: UILabel!
    @IBOutlet weak var premiumlbl: UILabel!
    
    var img = UIImage()
    var neim = ""
    var presio = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileIMG.image = img
        descripcionlbl.text = neim
        premiumlbl.text = presio

    }
    

    @IBAction func regresarBtn(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    
    }
    

}
