//
//  WaypointView.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI
import Combine
import CoreLocation
import MapKit

struct WaypointView: View {
    @EnvironmentObject var model: DataModel
    @Environment(\.presentationMode) var mode

    @ObservedObject var presenter: WaypointViewPresenter

    init(presenter: WaypointViewPresenter) {
      self.presenter = presenter
    }

    func applySuggestion() {
      presenter.didTapUseThis()
      mode.wrappedValue.dismiss()
    }

    var body: some View {
      return
        VStack{
          VStack {
            TextField("Type an Address", text: $presenter.query)
              .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack {
              Text(presenter.info)
              Spacer()
              Button(action: applySuggestion) {
                Text("Use this")
              }.disabled(!presenter.isValid)
            }

          }.padding([.horizontal])
          MapView(center: presenter.location)
        }.navigationBarTitle(Text(""), displayMode: .inline)
    }
  }

#Preview {
    let model = DataModel.sample
    let waypoint = model.trips[0].waypoints[0]
    let provider = RealMapDataProvider()
    
    return
      Group {
        NavigationView {
          WaypointView(presenter: WaypointViewPresenter(waypoint: waypoint, interactor: WaypointViewInteractor(waypoint: waypoint, mapInfoProvider: provider)))
            .environmentObject(model)
        }.previewDisplayName("Detail")
        NavigationView {
          WaypointView(presenter: WaypointViewPresenter(waypoint: Waypoint(), interactor: WaypointViewInteractor(waypoint:  Waypoint(), mapInfoProvider: provider)))
            .environmentObject(model)
            .previewDisplayName("New")
        }
    }
}
