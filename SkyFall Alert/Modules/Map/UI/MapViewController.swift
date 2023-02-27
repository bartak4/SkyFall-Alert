import UIKit
import MapKit
import SnapKit

/// View is stateless, only updates from data controller through 'MapViewType' protocol
/// Connection view -> data controller
/// # Example #
/// ```
/// func display(_ viewModel: MapViewModel)
/// func displayProfileImage(_ image: UIImage)
/// ```
protocol MapViewType: ViewType, AlertViewPresentable {
    func display(_ viewModel: MapViewModel)
}

final class MapViewController: UIViewController {
    
    public var dataController: MapViewDataControllerDelegate!
    private var viewModel: MapViewModel?
    
    let mainButton = UIButton()
    let mapView = MKMapView()
    let settingsButton = UIButton()
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataController.viewDidLoad()
        setupUI()
        styleViews()
        setUpMapView()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func didTapMainButton() {
        dataController.didTapMainButton()
    }
    
    @objc private func didTapSettings() {
        dataController.didTapSettings()
    }
    
    
    private func setupUI() {
        view.addSubview(mapView)
        view.addSubview(mainButton)
        view.addSubview(settingsButton)
        view.addSubview(resultLabel)

        mainButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(20)
        }
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(settingsButton)
            make.height.equalTo(settingsButton.snp.height)
        }
    }
    
    private func styleViews() {
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsCompass = false
        
        mainButton.setDefaultButtonStyle()
        mainButton.addTarget(self, action: #selector(didTapMainButton), for: .touchUpInside)

        settingsButton.setImage(UIImage(systemName: "gear")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        settingsButton.setTitleColor(.white, for: .normal)
        settingsButton.setDefaultButtonStyle()
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        
        resultLabel.textColor = .white
        resultLabel.backgroundColor = .gray.withAlphaComponent(0.7)
        resultLabel.layer.cornerRadius = 20
        resultLabel.layer.masksToBounds = true
    }
    
    
    private func setUpMapView() {
        // TODO: in future convert initialLocation to current position
        let initialLocation = CLLocation(latitude: 50.0691, longitude: 14.4276)
        mapView.centerToLocation(initialLocation)
        mapView.register(
            MeteorView.self,
            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }
}

extension MapViewController: MapViewType {
    
    /// Called when View and ViewModel are prepared
    /// - Parameter viewModel: View data for the current view
    /// # Example #
    /// ```
    /// nameLabel.text = viewModel.name
    /// ```
    func display(_ viewModel: MapViewModel) {
        self.viewModel = viewModel
        mapView.addAnnotations(viewModel.meteorites)
        if let meteorites = mapView.annotations as? [Meteorite] {
            let meteoritesToDelete = meteorites.filter { meteorite in
                !viewModel.meteorites.contains([meteorite])
            }
            mapView.removeAnnotations(meteoritesToDelete)
        }

        print(mapView.annotations.count)
        mainButton.setTitle(viewModel.mainButtonTitle, for: .normal)
        resultLabel.text = viewModel.resultTitle
        if viewModel.meteorites.count > 0 {
            resultLabel.isHidden = false
            resultLabel.text = viewModel.resultTitle
        } else {
            resultLabel.isHidden = true
        }
    }
}


extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 150000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let meteor = view.annotation as? Meteorite else {
            return
        }
        dataController.meteorSelected(meteor: meteor)
    }
}

