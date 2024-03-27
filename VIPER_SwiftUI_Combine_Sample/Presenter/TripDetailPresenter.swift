//
//  TripDetailPresenter.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI
import Combine

class TripDetailPresenter: ObservableObject {
    @Published var distanceLabel: String = "Calculatin..."
    @Published var waypoints = [Waypoint]()
    
    @Published var tripName: String = "no name"

    private let interactor: TripDetailInteractor
    private let router: TripDetailRouter
    private var cancelables = Set<AnyCancellable>()
    
    let setTripName: Binding<String>
    
    init(interactor: TripDetailInteractor) {
        self.interactor = interactor
        
        setTripName = Binding<String>(
            get: { interactor.tripName },
            set: { interactor.setTripName($0) }
        )
        
        self.router = TripDetailRouter(mapProvider: interactor.mapInfoProvider)
        
        interactor.tripNamePublisher
            .assign(to: \.tripName, on: self)
            .store(in: &cancelables)
        
        interactor.$totalDistance
            .map { "Total Distance: " + MeasurementFormatter().string(from: $0) }
            .replaceNil(with: "Calculating...")
            .assign(to: \.distanceLabel, on: self)
            .store(in: &cancelables)
        
        interactor.$waypoints
            .assign(to: \.waypoints, on: self)
            .store(in: &cancelables)
        
    }
    
    func save() {
        interactor.save()
    }
    
    func makeMapView() -> some View {
        TripMapView(presenter: TripMapViewPresenter(interactor: interactor))
    }
    
    func addWaypoint() {
      interactor.addWaypoint()
    }

    func didMoveWaypoint(fromOffsets: IndexSet, toOffset: Int) {
      interactor.moveWaypoint(fromOffsets: fromOffsets, toOffset: toOffset)
    }

    func didDeleteWaypoint(_ atOffsets: IndexSet) {
      interactor.deleteWaypoint(atOffsets: atOffsets)
    }

    func cell(for waypoint: Waypoint) -> some View {
      let destination = router.makeWaypointView(for: waypoint)
        .onDisappear(perform: interactor.updateWaypoints)
      return NavigationLink(destination: destination) {
        Text(waypoint.name)
      }
    }

}
