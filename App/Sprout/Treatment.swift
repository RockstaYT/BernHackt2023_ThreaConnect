//
//  Treatment.swift
//  Sprout
//
//  Created by Cedric Zwahlen on 26.08.23.
//

import Foundation

import SwiftUI

fileprivate let bg = Color(red: 0.98, green: 0.98, blue: 0.98)

fileprivate let t0 = 6
fileprivate let t1 = 10
fileprivate let t2 = 18
fileprivate let t3 = 22


struct MedicationView: View {
    
    @Binding var medication: Medication
    
    var body: some View {
        
        VStack(alignment: .leading) {
           
            HStack(alignment: .bottom) {
                Text(medication.name)
                    .font(.title)
                    .bold()
                Spacer()
                Text("\(medication.strength) mg")
                    .font(.title2)
                
                
                
            }
            
            
            
            Frequency(medication)
            
            Text(medication.notes)
                .font(.callout)
            
            
        }
        .padding()
        .background(.white)
        .cornerRadius(20)
        .padding()
        
    }
}

struct Frequency: View {
    
    @State var morning: Bool
    @State var midday: Bool
    @State var evening: Bool
    @State var night: Bool
    
    init(_ medication: Medication) {
        
        morning = medication.frequency[String.Index(utf16Offset: 0, in: medication.frequency)] == "1" ? true : false
        midday = medication.frequency[String.Index(utf16Offset: 1, in: medication.frequency)] == "1" ? true : false
        evening = medication.frequency[String.Index(utf16Offset: 2, in: medication.frequency)] == "1" ? true : false
        night = medication.frequency[String.Index(utf16Offset: 3, in: medication.frequency)] == "1" ? true : false
        
    }
    
    var body: some View {
        
        ZStack {
            
            Capsule()
                .foregroundColor(bg)
            
            HStack() {
                
                TimeIndicator(time: "sunrise", active: $morning, gradient: [.blue, .yellow])
                Spacer()
                TimeIndicator(time: "sun.max", active: $midday, gradient: [.yellow])
                Spacer()
                TimeIndicator(time: "sunset", active: $evening, gradient: [.blue, .orange])
                Spacer()
                TimeIndicator(time: "moon", active: $night, gradient: [.purple, .black])
                
            }
            
            .padding()
            
            
            
            
        }
        
        .padding()
        
        
    }
    
}

struct TimeIndicator: View {
    
    var time: String
    @Binding var active: Bool
    var gradient: [Color]
    
    var body: some View {
        
        Button("", action: {
            
            active.toggle()
            
        })
        .buttonStyle(TimeIndicatorButtonStyle(gradient: gradient, time: time, active: $active))
        
        
    }
    
}

struct TimeIndicatorButtonStyle: ButtonStyle {
    
    init(gradient: [Color], time: String, active: Binding<Bool>) {
        self.gradient = gradient
        self.time = time
        self._active = active
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        var d = true
        
        if hour >= t2 && hour < t3 && time == "sunset" { d = false }
        else if hour >= t1 && hour < t2 && time == "sun.max" { d = false }
        else if hour >= t0 && hour < t1 && time == "sunrise" { d = false }
        
        dim = d
        
        var l = true
        
        if hour >= t2 && time == "sunset" { l = false }
        else if hour >= t1 && time == "sun.max" { l = false }
        else if hour >= t0 && time == "sunrise" { l = false }
        
        later = l
        
        
        
    }
    
    
    
    var dim: Bool
    var gradient: [Color]
    var time: String
    var later: Bool
    @Binding var active: Bool
    
    
    func makeBody(configuration: Configuration) -> some View {
        
        
        ZStack {
            
            Circle()
               
                .foregroundColor(active ? (dim ? (later ? .white.opacity(0.9) : .white.opacity(0.7)) : .white) : bg)
                .shadow(color: active ? .gray : .clear, radius: active ? (dim ? (later ? 4 : 2) : 7) : 0)
                .animation(.spring(), value: active)
                
            Image(systemName: time)
                
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(0.55)
                .foregroundStyle(Gradient(colors: active ? (dim ? (later ? gradient : [.secondary]) : gradient) : [.secondary]))
                .animation(.spring(), value: active)
                
            
        }
        .scaleEffect(active ? (dim ? 0.950 : 1) : 0.925)
        .animation(.spring(), value: active)
        //.aspectRatio(contentMode: .fit)
        
    }
    
}

struct MedicationPreviewView: View {
    
    var prescription: Prescription
    
    @State var dues: [Medication]
    @State var overdue: [Medication]
    @State var dueLater: [Medication]
   
    
    init(_ prescription: Prescription) {
        self.prescription = prescription
        
        var medications = [Medication]()
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        for var medication in prescription.medications {
            
            var due = Array(repeating: false, count: 4)
            
            // disgusting, truly
            for i in 0..<4 {
                due[i] = medication.frequency[String.Index(utf16Offset: i, in: medication.frequency)] == "1" ? true : false
            }
            
            
            // check what medication to take next
            // overdue?
           
            
            
            // up next
            
            
            
            
            
            if hour >= t3 {
                // due
                for i in 3..<4 {
                    
                    let x = medication.frequency[String.Index(utf16Offset: i, in: medication.frequency)] == "1" ? true : false
                    let y = medication.taken[String.Index(utf16Offset: i, in: medication.taken)] == "1" ? true : false // taken cant cause error until next timeframe, but I guess that is not a problem for now
                    
                    if x && !y {
                        
                        if i == 3 {
                            medication.now = true
                        }
                        
                        medications.append(medication)
                    }
                    
                }
                
                // overdue
                for i in 0..<3 {
                    
                    let x = medication.frequency[String.Index(utf16Offset: i, in: medication.frequency)] == "1" ? true : false
                    let y = medication.taken[String.Index(utf16Offset: i, in: medication.taken)] == "1" ? true : false // taken cant cause error until next timeframe, but I guess that is not a problem for now
                    
                    if x && !y {
                        medication.overdue = true
                        medications.append(medication)
                    }
                    
                }
                
            } else if hour >= t2 {
                
                for i in 2..<4 {
                    
                    let x = medication.frequency[String.Index(utf16Offset: i, in: medication.frequency)] == "1" ? true : false
                    let y = medication.taken[String.Index(utf16Offset: i, in: medication.taken)] == "1" ? true : false // taken cant cause error until next timeframe, but I guess that is not a problem for now
                    
                    if x && !y {
                        
                        if i == 2 {
                            medication.now = true
                        }
                        
                        medications.append(medication)
                    }
                    
                }
                
                // overdue
                for i in 0..<2 {
                    
                    let x = medication.frequency[String.Index(utf16Offset: i, in: medication.frequency)] == "1" ? true : false
                    let y = medication.taken[String.Index(utf16Offset: i, in: medication.taken)] == "1" ? true : false // taken cant cause error until next timeframe, but I guess that is not a problem for now
                    
                    if x && !y {
                        medication.overdue = true
                        medications.append(medication)
                    }
                    
                }
                
            } else if hour >= t1 {
                
                for i in 1..<4 {
                    
                    let x = medication.frequency[String.Index(utf16Offset: i, in: medication.frequency)] == "1" ? true : false
                    let y = medication.taken[String.Index(utf16Offset: i, in: medication.taken)] == "1" ? true : false // taken cant cause error until next timeframe, but I guess that is not a problem for now
                    
                    if x && !y {
                        
                        if i == 1 {
                            medication.now = true
                        }
                        
                        medications.append(medication)
                    }
                    
                }
                
                // overdue
                for i in 0..<1 {
                    
                    let x = medication.frequency[String.Index(utf16Offset: i, in: medication.frequency)] == "1" ? true : false
                    let y = medication.taken[String.Index(utf16Offset: i, in: medication.taken)] == "1" ? true : false // taken cant cause error until next timeframe, but I guess that is not a problem for now
                    
                    if x && !y {
                        medication.overdue = true
                        medications.append(medication)
                    }
                    
                }
                
            } else if hour >= t0 {
                
                for i in 0..<4 {
                    
                    let x = medication.frequency[String.Index(utf16Offset: i, in: medication.frequency)] == "1" ? true : false
                    let y = medication.taken[String.Index(utf16Offset: i, in: medication.taken)] == "1" ? true : false // taken cant cause error until next timeframe, but I guess that is not a problem for now
                    
                    if x && !y {
                        
                        if i == 0 {
                            medication.now = true
                        }
                        
                        medications.append(medication)
                    }
                    
                }
                
            }
            
            
        }
        
        print(medications.count)
        print(medications.filter({ $0.overdue ?? false }).count)
        
        
        self.dueLater = Array(Set<Medication>( medications.filter({ $0.overdue ?? false == false && ($0.now ?? false) == false }) ))
        
        self.dues = Array(Set<Medication>( medications.filter({ $0.overdue ?? false == false && $0.now ?? false == true }) ))
        
        self.overdue = Array(Set<Medication>( medications.filter({ $0.overdue ?? false == true }) ))
        
        
        
    }
    
    var body: some View {
        
        VStack {
            
              
            
            
            if overdue.count > 0 {
                
                VStack {
                    
                    Text("Overdue")
                        .font(.title)
                        .bold()
                        .padding(.top)
                        //.foregroundColor(.white)
                    
                    Text("You missed at least one dose of this medication.")
                        .font(.callout)
                        .foregroundColor(.secondary)
                        //.foregroundColor(Color(red: 0.8, green: 0.8, blue: 0.8))
                    
                    
                    ForEach($overdue) { medication in
                        
                        MedicationView(medication: medication)
                            .shadow(radius: 2)
                        
                    }
                    
                }
                .background(Color(red: 236.0 / 255.0, green: 41.0 / 255.0, blue: 28.0 / 255.0)) // , ,
                .cornerRadius(30)
                .shadow(radius: 7)
                .padding()
                
                
            }
            
            
            
            
                
                
            
                
            if dues.count > 0 {
                
                VStack {
                    
                    Text("Due Now")
                        .font(.title)
                        .bold()
                        .padding(.top)
                    
                    Text("Take one dose of these medications now.")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    
                    ForEach($dues) { medication in
                        
                        MedicationView(medication: medication)
                            .shadow(radius: 2)
                    
                        
                    }
                    
                    
                    
                }
                .background(.white)
                .cornerRadius(30)
                .shadow(radius: 7)
                .padding()
                
            }
            
            
            
            
            
            if dueLater.count > 0 {
                
                VStack {
                    
                    Text("Due Later")
                        .font(.title)
                        .bold()
                        .padding(.top)
                    
                    Text("Take these medications later today.")
                        .font(.callout)
                        .foregroundColor(.secondary)
                    
                    ForEach($dueLater) { medication in
                        
                        MedicationView(medication: medication)
                            .shadow(radius: 2)
                    }
                    
                }
                .background(.white)
                .cornerRadius(30)
                .shadow(radius: 7)
                .padding()
                
                
            }
            
            
        }
        
        
    }
    
    
}




/*
struct Medication_Previews: PreviewProvider {
    static var previews: some View {
        List {
            
            Medication()
        }
    }
}
*/

struct Previews_Treatment_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
