//
//  ViewController.swift
//  ColeccionDeJuegos
//
//  Created by John Samuel Altamirano Sanchez on 10/13/21.
//  Copyright © 2021 empresa. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        setEditing(true, animated: true)
        //self.tableView.isEditing = true
        // Do any additional setup after loading the view.
    }

    

    @IBOutlet weak var tableView: UITableView!
    var juegos : [Juego] = []

    

    override func viewWillAppear(_ animated: Bool) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            try juegos = context.fetch(Juego.fetchRequest())
            tableView.reloadData()
        }catch{
        }
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return juegos.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
          let juego = juegos[indexPath.row]
               if editingStyle == .delete {
                  // Delete the row from the data source
                  //tableView.deleteRows(at: [indexPath], with: .fade)
                  //arregloNumeros.remove(at: indexPath.row)
                  //tableView.reloadData()
                
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                context.delete(juego)
                
                viewWillAppear(true)
               
               } else if editingStyle == .insert {
                   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
               }
        
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UITableViewCell
        
        let juego = juegos[indexPath.row]
        cell.textLabel?.text = juego.titulo
        cell.imageView?.image = UIImage(data: (juego.imagen!))
        cell.detailTextLabel?.text = juego.categoria
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let juego = juegos[indexPath.row]
        performSegue(withIdentifier: "s", sender: juego)
        print(juego)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let SiguienteVC = segue.destination as! JuegosViewController
        SiguienteVC.juego = sender as? Juego
    }
    
    
     // Override to support rearranging the table view.
     func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let objetivoMovido = self.juegos[sourceIndexPath.row]
        juegos.remove(at: sourceIndexPath.row)
        juegos.insert(objetivoMovido, at: destinationIndexPath.row)
        NSLog("%@", "\(sourceIndexPath.row) => \(destinationIndexPath.row) \(juegos)")
    }
     
}

