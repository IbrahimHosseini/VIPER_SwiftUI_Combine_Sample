//
//  TripListRouter.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI

class TripListRouter {
    func makeDetailView(for trip: Trip, model: DataModel) -> some View {
        let presenter = TripDetailPresenter(
            interactor: TripDetailInteractor(
                trip: trip,
                model: model,
                mapInfoProvider: RealMapDataProvider()
            )
        )
        
        return TripDetailView(presenter: presenter)
    }
}
