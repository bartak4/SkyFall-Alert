//
//  DetailMeteoriteCell.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 25.02.23.
//

import Foundation
import UIKit
import SnapKit

enum DetailMeteoriteCellComponent {
    case leftText(description: String), rightText(value: String), image(image: UIImage, classification: String)
}

struct DetailMeteoriteCellViewModel {
    let components: [DetailMeteoriteCellComponent]
}

final class DetailMeteoriteCell: UITableViewCell {
    
    private let leftText = UILabel()
    private let rightText = UILabel()
    private let middleText = UILabel()
    private let imageIcon = UIImageView()
    
    var viewModel: DetailMeteoriteCellViewModel!
    
    private func setupViews() {
        for component in viewModel.components {
            switch component {
                case .leftText(_):
                    addSubview(leftText)
                case .rightText(_):
                    addSubview(rightText)
                case .image(_, _):
                    addSubview(imageIcon)
                    addSubview(middleText)
            }
        }
    }
    
    private func setupConstraints() {
        for component in viewModel.components {
            switch component {
                case .leftText(_):
                    leftText.snp.makeConstraints { make in
                        make.top.bottom.equalToSuperview().inset(10)
                        make.left.equalToSuperview().inset(20)
                    }
                case .rightText(_):
                    rightText.snp.makeConstraints { make in
                        make.top.bottom.equalToSuperview().inset(10)
                        make.right.equalToSuperview().inset(20)
                    }
                case .image(_, _):
                    imageIcon.snp.makeConstraints { make in
                        make.top.bottom.equalToSuperview().inset(50)
                        make.centerY.centerX.equalToSuperview()
                    }
                    middleText.snp.makeConstraints { make in
                        make.bottom.equalToSuperview().inset(10)
                        make.centerX.equalToSuperview()
                    }
            }
        }
    }
    
    private func styleViews() {
        self.isUserInteractionEnabled = false
        self.layoutMargins = UIEdgeInsets.zero
    }

    func setup(_ viewModel: DetailMeteoriteCellViewModel) {
        self.viewModel = viewModel
        setupViews()
        setupConstraints()
        styleViews()
        
        for component in viewModel.components {
            switch component {
                case .leftText(description: let description):
                    leftText.text = description
                case .rightText(value: let value):
                    rightText.text = value
                case .image(image: let image, let classification):
                    if self.traitCollection.userInterfaceStyle == .dark {
                        // User Interface is Dark
                        imageIcon.image = image.resize(width: 60, height: 60)?.withTintColor(.white, renderingMode: .alwaysOriginal)
                    } else {
                        // User Interface is Light
                        imageIcon.image = image.resize(width: 60, height: 60)
                    }
                    middleText.text = classification
            }
        }
    }
}
