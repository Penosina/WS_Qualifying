//
//  GameTableViewCell.swift
//  WS_Qualifying
//
//  Created by Илья Абросимов on 20.04.2022.
//

import UIKit
import Kingfisher

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewIV: UIImageView!
    
    func configure(gameView: GamePreview) {
        selectionStyle = .none
        backgroundColor = .clear
        titleLabel.text = gameView.title
        if let url = URL(string: gameView.previewUrl) {
            previewIV.kf.setImage(with: url)
        }
    }
}
