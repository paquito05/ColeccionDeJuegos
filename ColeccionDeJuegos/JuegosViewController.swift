//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by John Samuel Altamirano Sanchez on 10/19/21.
//  Copyright © 2021 empresa. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        self.pinker.delegate = self
        self.pinker.dataSource = self
        
        pickerData = ["primera persona","RPG","MMO","batle royale","juegos de mesa","mundo abierto"]
        
        if juego != nil {
            JuegoImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            //pinker.select(juego!.categoria)
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    var pickerSeleccionado: String!
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickerSeleccionado = pickerData[row]
        print(pickerSeleccionado!)
    }
      
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    
    @IBOutlet weak var eliminarBoton: UIButton!
    
    @IBOutlet weak var pinker: UIPickerView!
    
    
    var pickerData : [String] = [String]()
    
    @IBAction func eliminarTapped(_ sender: Any) {
         let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func agregarTapped(_ sender: Any) {
        
        if juego != nil {
            juego!.titulo! = tituloTextField.text!
            juego!.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
            juego!.categoria = pickerSeleccionado
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    let juego = Juego(context: context)
                    juego.titulo = tituloTextField.text
                    juego.imagen = JuegoImageView.image?.jpegData(compressionQuality: 0.50)
                    
            juego.categoria = pickerSeleccionado
                    
        }
        
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
   
    var juego:Juego? = nil
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           let imagenSeleccionada = info[.originalImage] as? UIImage
           JuegoImageView.image = imagenSeleccionada
           imagePicker.dismiss(animated: true, completion: nil)
       }


}
