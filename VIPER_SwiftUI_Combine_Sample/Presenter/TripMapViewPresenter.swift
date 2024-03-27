//
//  TripMapViewPresenter.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import MapKit
import Combine

class TripMapViewPresenter: ObservableObject {
    @Published var pins: [MKAnnotation] = []
    @Published var routes: [MKRoute] = []
    
    let interactor: TripDetailInteractor
    private var cancellables = Set<AnyCancellable>()
    
    init(interactor: TripDetailInteractor) {
        self.interactor = interactor
        
        interactor.$waypoints
            .map {
                $0.map {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = $0.location
                    return annotation
                }
            }
            .assign(to: \.pins, on: self)
            .store(in: &cancellables)
        
        interactor.$directions
            .assign(to: \.routes, on: self)
            .store(in: &cancellables)
    }
}
