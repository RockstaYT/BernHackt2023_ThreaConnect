//
//  ContentView.swift
//  Sprout
//
//  Created by Cedric Zwahlen on 26.08.23.
//

import SwiftUI

struct ContentView: View {
    
    @State var prescriptions: [Prescription]
    
    var body: some View {
        
        
            
            
            
           // VStack(alignment: .center) {
                
                
                
                
                
                /*
                
                
                Text("All Prescriptions")
                    .font(.title)
                
                NavigationStack {
                    
                    
                    List(prescriptions) { prescription in
                        NavigationLink(prescription.id, value: prescription)
                            
                    }
                    
                    
                    .navigationDestination(for: Prescription.self) { prescription in
                        PrescriptionView(prescription: prescription)
                            .navigationTitle(prescription.id)
                    }
                    
                    .navigationTitle("Bitch Ass Hoe")
                    .toolbar() {
                        Button("Add") {
                            print("add")
                        }
                    }
                }
                
                 */
                
           // }
            
        
        
     
        
        ScrollView {
            
            ForEach($prescriptions) { prescription in
                
                MedicationPreviewView(prescription.wrappedValue)
                    
            }
            
        }
        
        
        
        
        .onAppear() {
            
            Task {
                
                let (data, _) = try await URLSession.shared.data(from: URL(string:"https://sprout-git-main-justtcg.vercel.app/api/prescription")!)
                
                do {
                    
                    prescriptions = try JSONDecoder().decode([Prescription].self, from: data)
                    
                    print(prescriptions)
                    
                } catch let e {
                    
                    print(e)
                    
                }
                
                
                
            }
            
        }
    }
}

struct Medication: CustomIdentifiable, Decodable, Hashable {
    
    
    static func == (lhs: Medication, rhs: Medication) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String
    
    var name : String
    var strength: Int
    var dosage: Int
    //var notes: String
    var frequency: String // ex: 0100
    var taken: String // ex: 1000
    var prescriptionId: String
    
    
    // set somewhere else, not in JSON
    
    var overdue: Bool? = false
    var now: Bool? = false
    
    
}

struct Prescription: CustomIdentifiable, Decodable, Hashable {
    
   
    static func == (lhs: Prescription, rhs: Prescription) -> Bool {
        lhs.id == rhs.id
    }
    
    var id: String
    
    var start: String
    var end: String
    
    var description: String
    
    var medications: [Medication]
    
}

struct PrescriptionView: View {
    
    @State var prescription: Prescription
        
    var body: some View {
        
        VStack(alignment: .center) {
           
            List($prescription.medications) { medication in
                MedicationView(medication: medication)
                    .padding()
                    .background(.background)
                    .cornerRadius(20)
                    .padding()
                    .shadow(radius: 4)
                    
            }
            
        }
        
        
    }
    
}

protocol CustomIdentifiable: Identifiable<String> {
        
    var id: String { get set }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(prescriptions: [Prescription(id: "1", start: "", end: "", description: "", medications: [Medication(id: "1", name: "Bla", strength: 2, dosage: 2, frequency: "0101", taken: "0011", prescriptionId: "1")])])
    }
}
