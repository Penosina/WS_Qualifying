//
//  GameView.swift
//  WS_Qualifying
//
//  Created by Илья Абросимов on 20.04.2022.
//

import SnapKit
import UIKit

class GameView: UIView {

    private let previewIV = UIImageView()
    private let titleLabel = UILabel()
    private let button = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setup() {
        addSubview(previewIV)
        addSubview(titleLabel)
        addSubview(button)
        
        previewIV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        previewIV.contentMode = .scaleToFill
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(24)
//            make.trailing.equalToSuperview().inset(224)
        }
        
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont(name: "Manrope-Bold", size: 32)
        titleLabel.textColor = .white
        
        button.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.bottom.equalToSuperview().inset(24)
        }
        
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        
        button.setTitle("Играть", for: .normal)
        button.setTitleColor(.white, for: .normal)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    func configure(gameView: GamePreview) {
        titleLabel.text = gameView.title
        if let url = URL(string: gameView.previewUrl) {
            previewIV.kf.setImage(with: url)
        }
    }
}
