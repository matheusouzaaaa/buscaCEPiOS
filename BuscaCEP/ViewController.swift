//
//  ViewController.swift
//  BuscaCEP
//
//  Created by Matheus Souza on 15/08/2020.
//  Copyright © 2020 Matheus Souza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtCep: UITextField!
    @IBOutlet weak var lblResultado: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBuscaCep(_ sender: Any) {
        if let cep = txtCep.text, cep.isEmpty {
            lblResultado.text = "Preencha o CEP"
        } else {
            if let url = URL(string: "https://viacep.com.br/ws/\(txtCep.text!)/json/"){
                print(url)
                let task = URLSession.shared.dataTask(with: url) { (dados, response, erro) in
                    if erro == nil {
                        if let dadosRetornados = dados {
                            do{
                                if let objJSON = try JSONSerialization.jsonObject(with: dadosRetornados, options: []) as? [String: Any] {
                                    if let logradouro = objJSON["logradouro"] as? String {
                                        print(logradouro)
                                        self.lblResultado.text = logradouro
                                    }
                                }
                            }catch{
                                print("Erro ao tratar os dados")
                            }
                        }
                    }else{
                        print("Erro ao tratar os dados")
                    }
                }
                task.resume()
            }
        }
    }
}

