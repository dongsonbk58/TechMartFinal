//
//  MapViewController.swift
//  TechMartFinal
//
//  Created by vu.thanh.long on 8/31/18.
//  Copyright © 2018 ThanhLong. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, BindableType {

    @IBOutlet private weak var place2TextField: UITextField!
    @IBOutlet private weak var directionButton: UIButton!
    @IBOutlet private weak var place1TextField: UITextField!
    
    var viewModel: MapViewModel!
    var mapView: GMSMapView!
    var currentLocationManager: CLLocationManager!
    var currentPlace: PlaceData = PlaceData()
    var place1: PlaceData = PlaceData()
    var place2: PlaceData = PlaceData()
    var typePlace: Int = -1
    var directionTrigger = PublishSubject<(PlaceData, PlaceData)>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confgView()
        loadCurrentLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    func confgView() {
        title = "Map"
        let camera = GMSCameraPosition.camera(withLatitude: 21.016630, longitude: 105.78, zoom: 11)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:  UIScreen.main.bounds.size.height - 60), camera: camera)
        mapView.isIndoorEnabled = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
       // mapView.delegate = self
        view.addSubview(mapView)
        view.bringSubview(toFront: place1TextField)
        view.bringSubview(toFront: place2TextField)
        view.bringSubview(toFront: directionButton)
    }
    
    func loadCurrentLocation() {
        currentLocationManager = CLLocationManager()
        currentLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        currentLocationManager.requestWhenInUseAuthorization()
        currentLocationManager.startUpdatingLocation()
        currentLocationManager.delegate = self
    }
    
    @IBAction func tapDirection(_ sender: UIButton) {
        if place1.title != "" && place2.title != "" {
            directionTrigger.onNext((place1, place2))
        }
    }
    
    func bindViewModel() {
        let input = MapViewModel.Input(loadTrigger: Driver.just(()),
                                       place1Trigger: place1TextField.rx.controlEvent([.editingDidBegin]).asDriver(),
                                       place2Trigger: place2TextField.rx.controlEvent([.editingDidBegin]).asDriver(),
                                       directionTrigger: directionTrigger.asDriverOnErrorJustComplete())
        
        let output = viewModel.transform(input)
        
        output.loadTrigger
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.place1Trigger
            .drive(placeBinder)
            .disposed(by: rx.disposeBag)
        
        output.place2Trigger
            .drive(placeBinder)
            .disposed(by: rx.disposeBag)
        
        output.direction
            .drive(directionBinder)
            .disposed(by: rx.disposeBag)
        
        output.error
            .drive(rx.error)
            .disposed(by: rx.disposeBag)
        
        output.indicator
            .drive(rx.isLoading)
            .disposed(by: rx.disposeBag)
    }
    
    private var placeBinder: Binder<Int> {
        return Binder(self, binding: { vc, type  in
           // MBProgressHUD.showAdded(to: vc.view, animated: true)
            let autoCompleteViewControlelr = GMSAutocompleteViewController()
            autoCompleteViewControlelr.delegate = self
            vc.typePlace = type
            vc.present(autoCompleteViewControlelr, animated: true, completion: {
             //   MBProgressHUD.hide(for: vc.view, animated: true)
            })
        })
    }
    
    private var directionBinder: Binder<GMSPath> {
        return Binder(self, binding: { vc, path  in
            print("path \(path)")
        })
    }

    func createMark(with place: PlaceData) {
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: CLLocationDegrees(place.lat),
                                                                longitude: CLLocationDegrees(place.long)))
        marker.snippet = "Hello"
        marker.appearAnimation = GMSMarkerAnimation.pop
        marker.map = mapView
    }
}

extension MapViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = Storyboards.map
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let current = locations[0]
        currentPlace = PlaceData()
        currentPlace.lat = Float(current.coordinate.latitude)
        currentPlace.long = Float(current.coordinate.longitude)
    }
}

extension MapViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        showOkAlert("Error", "Khong load duoc")
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let tmpPlace = PlaceData(lat: Float(place.coordinate.latitude),
                                 long: Float(place.coordinate.longitude),
                                 title: place.name)
        createMark(with: tmpPlace)
        if typePlace == 1 {
            place1 = tmpPlace
            place1TextField.text = tmpPlace.title
            mapView.camera = GMSCameraPosition.camera(withLatitude: CLLocationDegrees(tmpPlace.lat),
                                                      longitude: CLLocationDegrees(tmpPlace.long),
                                                      zoom: 11)
        } else {
            place2 = tmpPlace
            place2TextField.text = tmpPlace.title
        }
        dismiss(animated: true, completion: nil)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}
