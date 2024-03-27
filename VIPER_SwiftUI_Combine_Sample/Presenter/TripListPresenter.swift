//
//  TripListPresenter.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI
import Combine

class TripListPresenter: ObservableObject {
    private let interactor: TripListInteractor
    
    @Published var trips = [Trip]()
    
    private var cancellables = Set<AnyCancellable>()
    
    private let router = TripListRouter()
    
    init(interractor: TripListInteractor) {
        self.interactor = interractor
        
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
        interactor.addNewTrip()
    }
    
    func deleteTrip(_ index: IndexSet) {
        interactor.deleteTrip(index)
    }
    
    func linkbuilder<Content: View>(
        for trip: Trip,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: router.makeDetailView(
                for: trip,
                model: interactor.model
            )
        ) {
            content()
        }
        
    }
    
}
