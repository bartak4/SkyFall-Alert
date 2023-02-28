//
//  DetailMeteoriteViewController.swift
//  SkyFall Alert
//
//  Created by Bartak, Marek on 25.02.23.
//

import UIKit
import SnapKit
import MapKit

/// View is stateless, only updates from data controller through 'DetailMeteoriteViewType' protocol
/// Connection view -> data controller
/// # Example #
/// ```
/// func display(_ viewModel: DetailMeteoriteViewModel)
/// func displayProfileImage(_ image: UIImage)
/// ```
protocol DetailMeteoriteViewType: ViewType {
    func display(_ viewModel: DetailMeteoriteViewModel)
}

final class DetailMeteoriteViewController: UIViewController {
    
    public var dataController: DetailMeteoriteViewDataControllerDelegate!
    private var viewModel: DetailMeteoriteViewModel?
    
    private let tableView = UITableView()
    private let mapView =  MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        dataController.viewDidLoad()
        setupUI()
        styleViews()
        tableView.register(DetailMeteoriteCell.self, forCellReuseIdentifier: DetailMeteoriteCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapBack))
    }
    
    private func setupUI() {
        view.addSubview(mapView)
        view.addSubview(tableView)
        
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/2)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height/2)
        }
    }
    
    private func styleViews() {
        tableView.alwaysBounceVertical = false
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func didTapBack() {
        dataController.didTapBack()
    }
}

extension DetailMeteoriteViewController: DetailMeteoriteViewType {
    
    /// Called when View and ViewModel are prepared
    /// - Parameter viewModel: View data for the current view
    /// # Example #
    /// ```
    /// nameLabel.text = viewModel.name
    /// ```
    func display(_ viewModel: DetailMeteoriteViewModel) {
        self.viewModel = viewModel
        mapView.addAnnotation(viewModel.meteorite)
        let initialLocation = CLLocation(latitude: viewModel.meteorite.coordinate.latitude, longitude: viewModel.meteorite.coordinate.longitude)
        mapView.centerToLocation(initialLocation)
        tableView.reloadData()
    }
}

extension DetailMeteoriteViewController: MKMapViewDelegate { }


extension DetailMeteoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailMeteoriteCell.reuseIdentifier, for: indexPath) as? DetailMeteoriteCell
        cell?.setup((viewModel?.cellViewModels[indexPath.row])!)
        return cell ?? UITableViewCell()
    }
    
}
