//
//  LoginViewController.swift
//  NappsScheduler
//
//  Created by iem on 07/06/2018.
//  Copyright © 2018 Thomas Chaboud. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    var viewModel = LoginViewModel.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()

        //"Adresse mail invalide"
        //"Mot de passe incorrect"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(_ sender: Any) {
       
        
        if viewModel.isLoginEmpty(username: usernameTextField.text, password: passwordTextField.text){
             let alertController = UIAlertController(title: "Erreur", message: "Les champs ne doivent pas être vides !", preferredStyle: .alert)
             let cancel = UIAlertAction(title: "Ok", style: .default, handler:nil)
            alertController.addAction(cancel)
            present(alertController, animated: true, completion: nil)
            return
        }else if !viewModel.isLoginValid(username: usernameTextField.text, password: passwordTextField.text){
            let alertController = UIAlertController(title: "Erreur", message: "Adresse mail ou mot de passe incorrect !", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "Ok", style: .default, handler:nil)
            alertController.addAction(cancel)
            present(alertController, animated: true, completion: nil)
            return
        }else{
            performSegue(withIdentifier: "FromLoginToCalendar", sender: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
