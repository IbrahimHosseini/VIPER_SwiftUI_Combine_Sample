//
//  TripMapView.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI

struct TripMapView: View {
    @ObservedObject var presenter: TripMapViewPresenter
    
    var body: some View {
        MapView(
            pins: presenter.pins,
            routes: presenter.routes
        )
    }
}

#Preview {
    let model = DataModel.sample
    let trip = model.trips[0]
    let interactor = TripDetailInteractor(
        trip: trip,
        model: model,
        mapInfoProvider: RealMapDataProvider()
    )
    let presenter = TripMapViewPresenter(interactor: interactor)
    
    return VStack {
        TripMapView(presenter: presenter)
    }
}
