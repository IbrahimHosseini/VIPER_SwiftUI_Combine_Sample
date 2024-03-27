//
//  TripDetailRouter.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI

class TripDetailRouter {
    private let mapProvider: MapDataProvider
    
    init(mapProvider: MapDataProvider) {
        self.mapProvider = mapProvider
    }
    
    func makeWaypointView(for waypoint: Waypoint) -> some View {
        let presenter = WaypointViewPresenter(
            waypoint: waypoint,
            interactor: WaypointViewInteractor(
                waypoint: waypoint,
                mapInfoProvider: mapProvider))
        return WaypointView(presenter: presenter)
    }
}
