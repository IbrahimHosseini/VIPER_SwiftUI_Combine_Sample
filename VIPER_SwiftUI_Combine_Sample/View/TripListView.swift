//
//  TripListView.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI

struct TripListView: View {
    @ObservedObject var presenter: TripListPresenter
    
    var body: some View {
        List {
            ForEach(presenter.trips, id: \.id) { item in
                TripListCell(trip: item)
                    .frame(height: 240)
            }
        }
        .navigationTitle("Roadtrips")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing, content: presenter.makeAddNewButton)
        }
    }
}

#Preview {
    let model = DataModel.sample
    let interractor = TripListInteractor(model: model)
    let presenter = TripListPresenter(interractor: interractor)
    
    return NavigationView {
        TripListView(presenter: presenter)
    }
}
