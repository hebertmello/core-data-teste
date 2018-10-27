//
//  ViewController.swift
//  CoreDataTeste
//
//  Created by Hebert Falcão on 29/04/2018.
//  Copyright © 2018 hebertfalcao. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        /*
        // Inserir
        let usuario = NSEntityDescription.insertNewObject(forEntityName: "Usuario", into: context)

        usuario.setValue("Guilherme", forKey: "nome")
        usuario.setValue(20, forKey: "idade")
        usuario.setValue("gui", forKey: "login")
        usuario.setValue("2345", forKey: "senha")
        
        do {
            try context.save()
        } catch  {
            print("Erro ao salvar os dados!")
        }
        */
        
        // Listar
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        
        // Ordenar
        let ordenacaoNome = NSSortDescriptor(key: "nome", ascending: true)
        let ordenacaoIdade = NSSortDescriptor(key: "idade", ascending: true)
        requisicao.sortDescriptors = [ordenacaoNome, ordenacaoIdade]
        
        // Filtrar
        //let predicate = NSPredicate(format: "nome == %@", "Hebert")
        let predicate = NSPredicate(format: "nome contains [c] %@", "heb")
        //let predicate = NSPredicate(format: "nome beginswith [c] %@", "h")
        //let predicate = NSPredicate(format: "idade > %@", "30")
        
        //let filtroNome = NSPredicate(format: "nome contains [c] %@", "heb")
        //let filtroIdade = NSPredicate(format: "idade > %@", "30")
        //let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [filtroNome, filtroIdade])
        
        requisicao.predicate = predicate
        
        do {
            let usuarios = try context.fetch(requisicao)
            
            if usuarios.count > 0 {
                for usuario in usuarios as! [NSManagedObject] {
                    if let nomeUsuario = usuario.value(forKey: "nome") {
                        if let idadeUsuario = usuario.value(forKey: "idade") {
                            if let loginUsuario = usuario.value(forKey: "login") {
                                if let senhaUsuario = usuario.value(forKey: "senha") {
                                    print(String(describing: nomeUsuario) + " / " +
                                            String(describing: idadeUsuario) + " / " +
                                            String(describing: loginUsuario) + " / " +
                                            String(describing: senhaUsuario))
                                    
                                    /*
                                    // Remover
                                    context.delete(usuario)
                                    
                                    do {
                                        try context.save()
                                    } catch {
                                        print("Erro ao remover o usuario!")
                                    }
                                    */
                                    
                                    /*
                                    // Atualizar
                                    usuario.setValue("Hebert Falcao", forKey: "nome")
                                    
                                    do {
                                        try context.save()
                                    } catch {
                                        print("Erro ao atualizar o usuario!")
                                    }
                                    */
                                }
                            }
                        }
                    }
                }
            } else {
                print("Nenhum usuario encontrado!")
            }
        } catch  {
            print("Erro ao salvar os dados!")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

