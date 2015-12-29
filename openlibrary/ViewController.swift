//
//  ViewController.swift
//  openlibrary
//
//  Created by ANGEL GABRIEL RAMIREZ ALVA on 20/12/15.
//  Copyright © 2015 DDS.media. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet var isbn: UITextField!
    @IBOutlet var respuesta: UITextView!
    
    @IBOutlet weak var portada: UIImageView!
    @IBOutlet weak var autor: UITextView!
    
    
    func busca(){
       
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"+isbn.text!
        let url = NSURL(string: urls)
        
        let datos:NSData? = NSData(contentsOfURL: url!)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            let dico1 = json as! NSDictionary
            let dicoisbn: String = "ISBN:"+isbn.text!
            let dico2 = dico1["\(dicoisbn)"] as! NSDictionary
            self.titulo.text = dico2["title"] as! NSString as String
            let dicaut = dico2["authors"]?[0] as! NSDictionary
            autor.text = dicaut["name"] as! String
            let coverban = dico2["cover"]
            print(coverban)
            if coverban != nil {
                let dico3 = dico2["cover"] as! NSDictionary
                let cover: String = dico3["medium"] as! NSString as String
                let imgURL = NSURL(string: cover)
                let data = NSData(contentsOfURL: imgURL!)
                
                portada.contentMode = .ScaleAspectFit
                portada.image = UIImage(data: data!)
            }else{
                portada.image = UIImage(named: "bolas_ddsmedia.jpg")
            }
        
            
        }
        catch _ {
        
        }
        
        let texto = NSString(data:datos!, encoding:NSUTF8StringEncoding)
        respuesta.text! = texto as! String
        //print(texto!)
    }
    
    @IBAction func buscar(sender: AnyObject) {
        busca()
    }
    
    @IBAction func limpiar(sender: AnyObject) {
        isbn.text = "";
        respuesta.text = ""
        portada.image = UIImage(named: "bolas_ddsmedia.jpg")
        isbn.focused
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == isbn{
            busca()
        }
        
        self.view.endEditing(true)
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

