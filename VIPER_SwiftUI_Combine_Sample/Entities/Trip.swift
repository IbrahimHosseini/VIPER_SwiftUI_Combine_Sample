//
//  Trip.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import Foundation
import Combine

final class Trip {
    @Published var name: String = ""
    @Published var waypoints = [Waypoint]()
    let id: UUID
    
    init() {
        id = UUID()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        waypoints = try container.decode([Waypoint].self, forKey: .waypoints)
        id = try container.decode(UUID.self, forKey: .id)
    }
    
    func addWaypoint() {
        let waypoint = waypoints.last?.copy() ?? Waypoint()
        waypoint.name = "New Stop"
        waypoints.append(waypoint)
    }
}

extension Trip: Codable {
    enum CodingKeys: CodingKey {
        case name
        case waypoints
        case id
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(waypoints, forKey: .waypoints)
        try container.encode(id, forKey: .id)
    }
}

extension Trip: Identifiable {}

extension Trip: ObservableObject {}
