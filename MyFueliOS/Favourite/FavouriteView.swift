//
//  FavouriteScreen.swift
//  MyFueliOS
//
//  Created by Hung Tran on 13/3/21.
//

import SwiftUI

struct FavouriteView: View {
    @ObservedObject var viewModel = FavouriteViewModel()
    @State var isEditing = false
    @State private var currentTag = "Price"
    private let favService = CachedService.shared
  
    var body: some View {
     
        ZStack {
            NavigationView {
                    List {
                        ForEach(viewModel.favStations){ station in
                            NavigationLink (destination: StationDetailView(station: station)) {
                                StationRowView(petrolStation: station)
                            }
                        }.onDelete(perform: { indexSet in
                            let stationToDelete = indexSet.map { self.viewModel.favStations[$0] }[0]
                            favService.RemoveFromFavourites(station: stationToDelete)
                            viewModel.fetchFavouriteStations()
                        })
                        
            }.onAppear{
                viewModel.fetchFavouriteStations()
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Favourites")
                    
            //Binding List edit mode to isEditing var instead of using EditButton()
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    selectFuelTypeView
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    editButtonView
                }
              }
            }
            
            if(viewModel.isLoading){
                LoadingView()
            }
        }

}
    private var selectFuelTypeView: some View {
        Menu(content: {
            Picker("product", selection: $viewModel.product){
                ForEach(Product.allCases, id: \.self) { p in
                    Button(action: {
                       viewModel.product = p
                    }, label: {
                        Text(p.description)
                    })
                }
            }
        }) {
            HStack(spacing: 2) {
                Text(viewModel.product.description)
                        .font(.FjallaOne(size: 16))
                        .fixedSize(horizontal: true, vertical: false)
                Image(systemName: "chevron.down")
            }
        }
    }

    var editButtonView: some View {
        Button(action: {
            isEditing.toggle()
        }, label: {
            Image(systemName: "wrench")
                    .resizable()
                    .frame(width: 28, height: 28)
        })
    }
}
struct FavouriteScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView()
    }
}
