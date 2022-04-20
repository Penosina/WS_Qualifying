//
//  OnboardingViewController.swift
//  WS_Qualifying
//
//  Created by Илья Абросимов on 20.04.2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var nicknameTF: UITextField!
    
    @IBAction func login(_ sender: Any) {
        NetworkManager.shared.login(body: LoginEncodable(nickname: nicknameTF.text ?? "")) {
            self.navigationController?.setViewControllers([TabBarController()], animated: true)
        } onError: { [weak self] error in
            self?.showError(error)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
