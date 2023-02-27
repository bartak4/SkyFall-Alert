//
//  SliderView.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 26.02.23.
//

import Foundation
import UIKit
import SnapKit

enum SliderViewType {
    case mass, years
}

struct SliderViewModel {
    let min: Float
    let max: Float
    let title: String
    let type: SliderViewType
    let presentValue: Float
    let valueHandler: (Float) -> Void
}

final class SliderView: UIView {
    
    private let title = UILabel()
    private let minLabel = UILabel()
    private let valueLabel = UILabel()
    private let maxLabel = UILabel()
    private let slider = UISlider()
    
    private var viewModel: SliderViewModel!
    
    func setupViews() {
        addSubview(slider)
        addSubview(minLabel)
        addSubview(valueLabel)
        addSubview(maxLabel)
        addSubview(title)
    }
    
    func setupConstraints() {
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        maxLabel.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(6)
            make.trailing.equalToSuperview().inset(20)
        }
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        minLabel.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(6)
            make.leading.equalToSuperview().inset(20)
        }
        slider.snp.makeConstraints { make in
            make.top.equalTo(minLabel.snp.bottom)
            make.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func styleViews() {
        minLabel.textColor = .gray.withAlphaComponent(0.5)
        minLabel.font = .systemFont(ofSize: 8)
        maxLabel.textColor = .gray.withAlphaComponent(0.5)
        maxLabel.font = .systemFont(ofSize: 8)
        valueLabel.textColor = .gray.withAlphaComponent(0.5)
        valueLabel.font = .systemFont(ofSize: 8)
        slider.isContinuous = true
        slider.isUserInteractionEnabled = true
        title.textColor = .gray.withAlphaComponent(0.5)
        title.font = .systemFont(ofSize: 14)
    }

    func setup(_ viewModel: SliderViewModel) {
        self.viewModel = viewModel
        setupViews()
        setupConstraints()
        styleViews()

        slider.minimumValue = viewModel.min
        slider.maximumValue = viewModel.max
        slider.setValue(viewModel.presentValue, animated: true)
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        title.text = viewModel.title

        switch viewModel.type {
            case .mass:
                slider.minimumValueImage = UIImage(named: "meteorSmall")!.resize(width: 10, height: 10)!
                slider.maximumValueImage = UIImage(named: "meteorBig")!.resize(width: 20, height: 20)!
                minLabel.text = viewModel.min.formattedWithSeparator
                maxLabel.text = viewModel.max.formattedWithSeparator
            case .years:
                slider.minimumValueImage = UIImage(named: "olderMan")!.resize(width: 20, height: 20)!
                slider.maximumValueImage = UIImage(named: "youngerMan")!.resize(width: 20, height: 20)!
                minLabel.text = String(Int(viewModel.min))
                maxLabel.text = String(Int(viewModel.max))
        }
    }
    
    
    @objc func sliderValueDidChange(_ sender:UISlider!) {
        switch viewModel.type {
            case .mass:
                valueLabel.text = Int(sender.value).formattedWithSeparator
            case .years:
                valueLabel.text = String(Int(sender.value))
        }
        viewModel.valueHandler(sender.value)
    }
}
