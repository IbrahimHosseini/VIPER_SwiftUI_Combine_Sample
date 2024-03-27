//
//  TripListRouter.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI

class TripListRouter {
    func makeDetailView(for trip: Trip, model: DataModel) -> some View {
        
        let mapProvider = RealMapDataProvider()
        
        let interractor = TripDetailInteractor(
            trip: trip,
            model: model,
            mapInfoProvider: mapProvider
        )
        
        let presenter = TripDetailPresenter(interactor: interractor)
        
        return TripDetailView(presenter: presenter)
    }
}
