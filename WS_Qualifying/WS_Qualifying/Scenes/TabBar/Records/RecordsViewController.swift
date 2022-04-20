//
//  RecordsViewController.swift
//  WS_Qualifying
//
//  Created by Илья Абросимов on 20.04.2022.
//

import UIKit

class RecordsViewController: UIViewController {

    private var records: [Record] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "RecordTableViewCell", bundle: nil), forCellReuseIdentifier: "RecordTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NetworkManager.shared.getRecords { [weak self] records in
            self?.records = records.sorted(by: { $0.points > $1.points })
            self?.tableView.reloadData()
        } onError: { [weak self] error in
            self?.showError(error)
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
extension RecordsViewController: UITableViewDelegate & UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell") as? RecordTableViewCell,
            indexPath.row < records.count
        else {
            return UITableViewCell()
        }
        
        cell.configure(place: indexPath.row + 1, record: records[indexPath.row])
        return cell
    }
    
    
}
