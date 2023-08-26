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
