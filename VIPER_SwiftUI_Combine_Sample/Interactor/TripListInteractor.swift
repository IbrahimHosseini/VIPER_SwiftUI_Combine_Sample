//
//  TripListInteractor.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import Foundation

class TripListInteractor {
    let model: DataModel
    
    init(model: DataModel) {
        self.model = model
    }
    
    func addNewTrip() {
        model.pushNewtrip()
    }
    
    func deleteTrip(_ index: IndexSet) {
        model.trips.remove(atOffsets: index)
    }
}
