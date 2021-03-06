//
//  SwiftUIView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 6/3/21.
//

import SwiftUI
struct SelectedStationDetailView: View {
    @Binding var station: PetrolStation

    var body: some View {
      
        VStack{
            HStack {
                Text(station.brand)
                    //TODO: replace this TextCircle with brand Logo
                    .font(.footnote)
                    .frame(width: 48, height: 48, alignment: .center)
                    .padding()
                    .overlay(
                        Circle()
                        .stroke(Color.blue, lineWidth: 4)
                        .padding(6)
                    )
        
                VStack (spacing: 4) {
                    HStack {
                        Text(station.tradingName).font(.headline)
                        Spacer()
                        Text(station.price).font(.title2)
                    }.padding(EdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 8))
                    
                    HStack {
                        Text(station.address).font(.subheadline)
                        Spacer()
                        Text("Fuel Watch WA").font(.caption2)
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                    
                    HStack {
                        Spacer()
                        Text(station.distance).italic()
                        
                        Button(action: {
                            //TODO: Implement navigation
                            print("Navigate button was tapped")
                        }) {
                          
                            HStack(spacing: 10) {
                                Text("Navigate")
                                Image(systemName: "arrow.triangle.turn.up.right.circle.fill")
                                    .resizable()
                                    .frame(width: 28, height: 28, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                              } .frame(minWidth: 0, maxWidth: 120, minHeight: 28, maxHeight: 36)
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                        }
                    }.padding(EdgeInsets(top: -2, leading: 0, bottom: 8, trailing: 8))
                }
            }
    
        }
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static private var station = Binding.constant(PetrolStation.mockPetrolStations[0])

    static var previews: some View {
        SelectedStationDetailView(station: station)
    }
}
