//
//  SegmentedControl.swift
//  MyFueliOS
//
//  Created by Thinh Tran on 3/3/21.
//

import SwiftUI

// similar with searchbar is searchbar scopebuttontitles
struct SegmentedControl: View {
    @State private var favoriteColor = 0

    var body: some View {
        VStack {
                  Picker(selection: $favoriteColor, label: Text("Sort by price or by distance")) {
                      Text("Price").tag(0)
                      Text("Distance").tag(1)
                  }
                  .pickerStyle(SegmentedPickerStyle())
              }
    }
}

struct SegmentedControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedControl()
    }
}
