//
//  TripDetailPresenter.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI
import Combine

class TripDetailPresenter: ObservableObject {
    private let interactor: TripDetailInteractor
    
    private var cancelables = Set<AnyCancellable>()
    
    @Published var tripName: String = "no name"
    let setTripName: Binding<String>
    
    init(interactor: TripDetailInteractor) {
        self.interactor = interactor
        
        setTripName = Binding<String>(
            get: { interactor.tripName },
            set: { interactor.setTripName($0) }
        )
        
        interactor.tripNamePublisher
            .assign(to: \.tripName, on: self)
            .store(in: &cancelables)
    }
    
    func save() {
        interactor.save()
    }
}
