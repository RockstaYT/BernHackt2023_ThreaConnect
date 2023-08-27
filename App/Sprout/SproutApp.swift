//
//  SproutApp.swift
//  Sprout
//
//  Created by Cedric Zwahlen on 26.08.23.
//

import SwiftUI

@main
struct SproutApp: App {
    var body: some Scene {
        WindowGroup {
           ContentView(prescriptions: [Prescription(id: "", start: "", end: "", description: "", medications: [])])
            
           // ContentView(prescription: Prescription(id: "", start: "", end: "", description: "", medications: []))
        }
    }
}

struct Previews_SproutApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
