//
//  GameViewController.swift
//  WS_Qualifying
//
//  Created by Илья Абросимов on 20.04.2022.
//

import UIKit

enum Task {
    case color, number, form
}

class GameViewController: UIViewController {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var pointslabel: UILabel!
    @IBOutlet weak var gameView: UIView!
    private let tasks: [Task] = [
        .number, .color, .form
    ]
    private var curState: Task = .number {
        didSet {
            switch curState {
            case .form:
                taskLabel.text = "Форма!"
            case .number:
                taskLabel.text = "Число!"
            case .color:
                taskLabel.text = "Цвет!"
            }
        }
    }
    
    private var points: Int = 0 {
        didSet {
            pointslabel.text = "\(points)"
        }
    }
    @IBAction func cancelGame(_ sender: Any) {
        NetworkManager.shared.postPoints(body: Points(points: points)) { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        } onError: { [weak self] error in
            self?.showError(error)
        }
    }
    
    @objc private func givePoints() {
        points += 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startGame()
    }

    func startGame() {
        let randState = tasks.randomElement() ?? .color
        curState = randState
        points = 0
        getRomb()
        getRomb()
        getRomb()
        getRomb()
    }

    func getRomb()  {
        let randX = CGFloat.random(in: 0..<gameView.frame.width)
        let randY = CGFloat.random(in: 0..<gameView.frame.height)
        let rombView = UIImageView(image: UIImage(named: "romb"))
        gameView.addSubview(rombView)
        rombView.bounds = CGRect(x: randX, y: randY, width: 40, height: 40)
        rombView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(givePoints))
        rombView.addGestureRecognizer(gesture)
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
