//
//  TabBarController.swift
//  WS_Qualifying
//
//  Created by Илья Абросимов on 20.04.2022.
//

import UIKit

class TabBarController: UITabBarController {

    private let firstVC = UINavigationController(rootViewController: MainViewController())
    private let secondVC = UINavigationController(rootViewController: RecordsViewController())
    private let thirdVC = UINavigationController(rootViewController: ProfileViewController())
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setup() {
        firstVC.isNavigationBarHidden = true
        firstVC.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "home"), selectedImage: nil)
        secondVC.isNavigationBarHidden = true
        secondVC.tabBarItem = UITabBarItem(title: "Рейтинг", image: UIImage(named: "records"), selectedImage: nil)
        thirdVC.isNavigationBarHidden = true
        thirdVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "profile"), selectedImage: nil)
        
        tabBar.tintColor = UIColor(named: "colorEZ")
        tabBar.barTintColor = UIColor(named: "lightBlue")
        setViewControllers([firstVC, secondVC, thirdVC], animated: true)
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
