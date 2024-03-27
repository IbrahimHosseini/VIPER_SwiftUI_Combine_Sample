//
//  TripDetailInteractor.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import Combine
import MapKit

class TripDetailInteractor {
    private let trip: Trip
    private let model: DataModel
    let mapInfoProvider: MapDataProvider
    
    var tripName: String { trip.name }
    var tripNamePublisher: Published<String>.Publisher { trip.$name }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(trip: Trip, model: DataModel, mapInfoProvider: MapDataProvider) {
        self.trip = trip
        self.model = model
        self.mapInfoProvider = mapInfoProvider
    }
    
    func setTripName(_ name: String) {
        trip.name = name
    }
    
    func save() {
        model.save()
    }
}
