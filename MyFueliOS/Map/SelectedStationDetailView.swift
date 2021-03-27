//
//  SwiftUIView.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 6/3/21.
//

import SwiftUI
struct SelectedStationDetailView: View {
    @Binding var station: PetrolStation?
    @State var expandedState: ViewExpandedState = ViewExpandedState.One
    @State private var stationDetailIsShowing = false
    var body: some View {
      
        VStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.gray.opacity(0.5))
                          .frame(width: 48, height: 6)
            if let station = station {
                StationRowView(petrolStation: station)
            }
            Button(action: {
                //Open apple map
                let url = URL(string: "http://maps.apple.com/?address=\(station!.address.replacingOccurrences(of: " ", with: "+"))")
                if let url = url {
                    UIApplication.shared.open(url)
                }
            }) {
              
                HStack(spacing: 10) {
                    Spacer()
                    Text("Navigate").font(.FHACondFrenchNC(size: 18))
                    Image(systemName: "arrow.triangle.turn.up.right.circle")
                        .resizable()
                        .frame(width: 28, height: 28, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                  }
               
                .frame( height: 42, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
            }.padding(EdgeInsets(top: -4, leading: 32, bottom: 8, trailing: 32))
                
        
        }
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        .background(Color.white)
        .cornerRadius(32, corners: [.topLeft, .topRight])
        .shadow(color: Color.black.opacity(0.3),
            radius: 5, x: 3,y: -3)
        .gesture(DragGesture().onEnded{ value in
            if(value.translation.height < 0) { //up
                stationDetailIsShowing = true
            }
            else if (value.translation.height > 0 ){
                station = nil
            }
           
        }).sheet(isPresented: $stationDetailIsShowing, onDismiss: {}, content: {
            NavigationView {
                if let station = station {
                    StationDetailView(station: station)
                }
            }.navigationViewStyle(StackNavigationViewStyle())
        })
    }
    
    private func getHeight() -> CGFloat {
        switch expandedState {
        case ViewExpandedState.One:
            return 200
        case ViewExpandedState.Two:
            return 400
        case ViewExpandedState.Three:
            return 600
        }
    }
}

enum ViewExpandedState{
    case One
    case Two
    case Three
}


struct SwiftUIView_Previews: PreviewProvider {
    static private var station = Binding.constant(PetrolStation.mockPetrolStations[0])

    static var previews: some View {
        ZStack{
            Color.white.opacity(0.5)
            SelectedStationDetailView(station: Binding(station))
        }
    }
}
