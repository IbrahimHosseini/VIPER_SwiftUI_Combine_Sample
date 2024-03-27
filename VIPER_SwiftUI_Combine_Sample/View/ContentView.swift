//
//  ContentView.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: DataModel
    
    var body: some View {
        NavigationView {
            TripListView(
                presenter: TripListPresenter(
                    interractor: TripListInteractor(
                        model: model
                    )
                )
            )
        }
    }
}

#Preview {
    let model = DataModel.sample
    return ContentView()
        .environmentObject(model)
}
