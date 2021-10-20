//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by John Samuel Altamirano Sanchez on 10/19/21.
//  Copyright © 2021 empresa. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
      
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
       
    
    @IBAction func agregarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
          let juego = Juego(context: context)
          juego.titulo = tituloTextField.text
          juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
          (UIApplication.shared.delegate as! AppDelegate).saveContext()
          navigationController?.popViewController(animated: true)
    }
    
 
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    
    @IBAction func camaraTapped(_ sender: Any) {
    }
    
    var imagePicker = UIImagePickerController()
   
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           let imagenSeleccionada = info[.originalImage] as? UIImage
           JuegoImageView.image = imagenSeleccionada
           imagePicker.dismiss(animated: true, completion: nil)
       }


}
