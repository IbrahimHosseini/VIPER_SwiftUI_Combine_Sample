//
//  TripListCell.swift
//  VIPER_SwiftUI_Combine_Sample
//
//  Created by Ibrahim on 3/27/24.
//

import SwiftUI
import Combine

struct TripListCell: View {
    
    let imageProvider: ImageDataProvider = PixabayImageDataProvider()
    
    @ObservedObject var trip: Trip
    
    @State private var images = [UIImage]()
    @State private var cancellable: AnyCancellable?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                SplitImage(images: self.images)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                BlurView()
                    .frame(width: geometry.size.width, height: 42)
                
                Text(self.trip.name)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 4, trailing: 8))
            }
            .clipShape(.rect(cornerRadius: 12))
        }
        .onAppear() {
            self.cancellable = self.imageProvider.getEndImages(for: self.trip).assign(to: \.images, on: self)
        }
    }
}

#Preview {
    let model = DataModel.sample
    let trip = model.trips[0]
    return TripListCell(trip: trip)
        .frame(height: 160)
        .environmentObject(model)
}

struct BlurView: UIViewRepresentable {
  func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
    let view = UIView()
    view.backgroundColor = .clear
    let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
    let blurView = UIVisualEffectView(effect: blurEffect)
    blurView.translatesAutoresizingMaskIntoConstraints = false
    view.insertSubview(blurView, at: 0)
    NSLayoutConstraint.activate([
      blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
      blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
    ])
    return view
  }

  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<BlurView>) {
  }
}
