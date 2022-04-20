//
//  MainViewController.swift
//  WS_Qualifying
//
//  Created by Илья Абросимов on 20.04.2022.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    var games: [GamePreview] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GameTableViewCell", bundle: nil), forCellReuseIdentifier: "GameTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear

        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.tabBarController?.tabBar.isHidden = false
        NetworkManager.shared.getGames { [weak self] gamePreviews in
            self?.games = gamePreviews
            self?.setupGames()
        } onError: { [weak self] error in
            self?.showError(error)
        }
    }

    func setupGames() {
        tableView.reloadData()
        stackView.subviews.forEach { subview in
            subview.removeFromSuperview()
        }
        
        games.forEach { gamePreview in
            let gameView = GameView()
            gameView.configure(gameView: gamePreview)
            stackView.addArrangedSubview(gameView)
        }
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

extension MainViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell") as? GameTableViewCell,
            indexPath.row < games.count else {
            return UITableViewCell()
        }
                
        cell.configure(gameView: games[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(GameViewController(), animated: true)
    }
    
}
