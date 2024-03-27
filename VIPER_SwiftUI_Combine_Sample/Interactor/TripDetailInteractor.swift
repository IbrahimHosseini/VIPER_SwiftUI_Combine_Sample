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
    
    @Published var totalDistance: Measurement<UnitLength> = Measurement(value: 0, unit: .meters)
    @Published var waypoints = [Waypoint]()
    @Published var directions = [MKRoute]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(trip: Trip, model: DataModel, mapInfoProvider: MapDataProvider) {
        self.trip = trip
        self.model = model
        self.mapInfoProvider = mapInfoProvider
        
        trip.$waypoints
            .assign(to: \.waypoints, on: self)
            .store(in: &cancellables)
        
        trip.$waypoints
            .flatMap { mapInfoProvider.totalDistance(for: $0) }
            .map { Measurement(value: $0, unit: UnitLength.meters) }
            .assign(to: \.totalDistance, on: self)
            .store(in: &cancellables)
        
        trip.$waypoints
            .setFailureType(to: Error.self)
            .flatMap { mapInfoProvider.directions(for: $0) }
            .catch { _ in Empty<[MKRoute], Never>() }
            .assign(to: \.directions, on: self)
            .store(in: &cancellables)
    }
    
    func setTripName(_ name: String) {
        trip.name = name
    }
    
    func save() {
        model.save()
    }
    
    func addWaypoint() {
       trip.addWaypoint()
    }

    func moveWaypoint(fromOffsets: IndexSet, toOffset: Int) {
     trip.waypoints.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }

    func deleteWaypoint(atOffsets: IndexSet) {
      trip.waypoints.remove(atOffsets: atOffsets)
    }

    func updateWaypoints() {
      trip.waypoints = trip.waypoints
    }

}
