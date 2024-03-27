//
//  TripDetailView.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI

struct TripDetailView: View {
    @ObservedObject var presenter: TripDetailPresenter
    
    var body: some View {
        VStack {
            TextField("Trip Name", text: presenter.setTripName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.horizontal])
        }
        .navigationTitle("\(presenter.tripName)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    presenter.save()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

#Preview {
    
    let model = DataModel.sample
    let trip = model.trips[1]
    let mapProvider = RealMapDataProvider()
    let presenter = TripDetailPresenter(
        interactor: TripDetailInteractor(
            trip: trip,
            model: model,
            mapInfoProvider: mapProvider
        )
    )
    
    return NavigationView {
        TripDetailView(presenter: presenter)
    }
}
