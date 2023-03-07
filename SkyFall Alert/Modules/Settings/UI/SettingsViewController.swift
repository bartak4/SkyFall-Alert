//
//  SettingsViewController.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 25.02.23.
//

import UIKit
import SnapKit
import MapKit

/// View is stateless, only updates from data controller through 'SettingsViewType' protocol
/// Connection view -> data controller
/// # Example #
/// ```
/// func display(_ viewModel: SettingsViewModel)
/// func displayProfileImage(_ image: UIImage)
/// ```
protocol SettingsViewType: ViewType {
    func display(_ viewModel: SettingsViewModel)
}

final class SettingsViewController: UIViewController {
    
    private let settingsTitle = UILabel()
    private let sliderMassView = SliderView()
    private let sliderYaerView = SliderView()
    private let confirmButton = UIButton()
    
    public var dataController: SettingsViewDataControllerDelegate!
    private var viewModel: SettingsViewModel?
    
    private var massSliderValue: Float = 0
    private var yearsSliderValue: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataController.viewDidLoad()
        setupUI()
        styleViews()
    }
    
    private func setupUI() {
        view.addSubview(settingsTitle)
        view.addSubview(sliderMassView)
        view.addSubview(sliderYaerView)
        view.addSubview(confirmButton)
        
        settingsTitle.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
        }
        sliderMassView.snp.makeConstraints { make in
            make.top.equalTo(settingsTitle.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
        }
        sliderYaerView.snp.makeConstraints { make in
            make.top.equalTo(sliderMassView.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
        }
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func styleViews() {
        view.backgroundColor = .white
        settingsTitle.font = .systemFont(ofSize: 30)
        settingsTitle.textColor = .black
        confirmButton.setDefaultButtonStyle()
        confirmButton.addTarget(self, action: #selector(didTapConfirm), for: .touchUpInside)
    }
    
    @objc private func didTapConfirm() {
        dataController.didTapConfirm(massValue: massSliderValue, yearsValue: yearsSliderValue)
    }
}

extension SettingsViewController: SettingsViewType {
    
    /// Called when View and ViewModel are prepared
    /// - Parameter viewModel: View data for the current view
    /// # Example #
    /// ```
    /// nameLabel.text = viewModel.name
    /// ```
    func display(_ viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        confirmButton.setTitle(viewModel.confirmButtonTitle, for: .normal)
        settingsTitle.text = viewModel.title
        massSliderValue = viewModel.currentFilterMass
        yearsSliderValue = viewModel.currentFilterYears
        sliderMassView.setup(SliderViewModel(min: viewModel.massMin, max: viewModel.massMax, title: viewModel.massTitle, type: .mass, presentValue: viewModel.currentFilterMass, valueHandler: {value in self.massSliderValue = value}))
        sliderYaerView.setup(SliderViewModel(min: viewModel.minYear, max: viewModel.maxYear, title: viewModel.yearTitle, type: .years, presentValue: viewModel.currentFilterYears, valueHandler: {value in self.yearsSliderValue = value}))
    }
}

