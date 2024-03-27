//
//  WaypointViewInteractor.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import Foundation
import Combine
import CoreLocation

class WaypointViewInteractor {
  private let waypoint: Waypoint
  private let mapInfoProvider: MapDataProvider

  init(waypoint: Waypoint, mapInfoProvider: MapDataProvider) {
    self.waypoint = waypoint
    self.mapInfoProvider = mapInfoProvider
  }

  func getLocation(for address:String) -> AnyPublisher<CLPlacemark, Error> {
    mapInfoProvider.getLocation(for: address)
  }

  func apply(name: String, location: CLLocationCoordinate2D) {
    waypoint.name = name
    waypoint.location = location
  }
}
