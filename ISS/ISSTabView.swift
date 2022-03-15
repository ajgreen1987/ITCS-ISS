//
//  ContentView.swift
//  ISS
//
//  Created by AJ Green on 3/14/22.
//

import SwiftUI

struct ISSTabView: View {
    var body: some View {
        TabView{
            // SF Symbols for the system image name
            MapView().tabItem{Label("Map", systemImage: "map")}
            AstronautListView().tabItem{Label("Astronauts", systemImage: "person.3.fill")}
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ISSTabView()
    }
}
