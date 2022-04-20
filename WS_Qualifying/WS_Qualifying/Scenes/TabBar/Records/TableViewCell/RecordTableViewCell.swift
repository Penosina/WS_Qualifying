//
//  RecordTableViewCell.swift
//  WS_Qualifying
//
//  Created by Илья Абросимов on 20.04.2022.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    @IBOutlet weak var placeLabel: UILabel!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(place: Int, record: Record) {
        selectionStyle = .none
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        backgroundColor = .clear
        placeLabel.text = "\(place)"
        nicknameLabel.text = record.userNickname
        pointsLabel.text = "\(record.points)"
    }
    
}
