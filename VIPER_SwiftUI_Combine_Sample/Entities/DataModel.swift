//
//  DataModel.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import Combine

final class DataModel {
    private let persistance: Persistance = Persistance()
    
    @Published var trips = [Trip]()
    
    private var cancellables = Set<AnyCancellable>()
    
    func load() {
        persistance.load()
            .assign(to: \.trips, on: self)
            .store(in: &cancellables)
    }
    
    func save() {
        persistance.save(trips: trips)
    }
    
    func loadDefault(synchronous: Bool = false) {
        persistance.loadDefault(synchronously: synchronous)
            .assign(to: \.trips, on: self)
            .store(in: &cancellables)
    }
    
    func pushNewtrip() {
        let new = Trip()
        new.name = "New Trip"
        trips.insert(new, at: 0)
    }
    
    func newTrip(trip: Trip) {
        trips.removeAll { $0.id == trip.id }
    }
}

extension DataModel: ObservableObject {}

#if DEBUG
extension DataModel {
    static var sample: DataModel {
        let model = DataModel()
        model.loadDefault(synchronous: true)
        return model
    }
}
#endif
