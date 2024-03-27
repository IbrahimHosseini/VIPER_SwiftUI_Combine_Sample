//
//  TripListPresenter.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI
import Combine

class TripListPresenter: ObservableObject {
    private let interractor: TripListInteractor
    
    @Published var trips = [Trip]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(interractor: TripListInteractor) {
        self.interractor = interractor
        
        interractor.model.$trips
            .assign(to: \.trips, on: self)
            .store(in: &cancellables)
    }
    
    func makeAddNewButton() -> some View {
        Button(action: addNewTrip) {
            Image(systemName: "plus")
        }
    }
    
    func addNewTrip() {
        interractor.addNewTrip()
    }
}
