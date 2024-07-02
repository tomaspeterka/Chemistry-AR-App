//
//  ContentView.swift
//  AugmentedReality
//
//  Created by Tomáš Peterka on 09.01.2024.
//  Topic of meeting Maty<>Tomáš
//

import SwiftUI
import RealityKit
import ARKit

let periodicTable: [PeriodicElement] = [
    PeriodicElement(name: "Hydrogen", atomicNumber: 1, numberOfProtons: 1, numberOfElectrons: 1, numberOfNeutrons: 0),
    PeriodicElement(name: "Helium", atomicNumber: 2, numberOfProtons: 2, numberOfElectrons: 2, numberOfNeutrons: 2),
    PeriodicElement(name: "Lithium", atomicNumber: 3, numberOfProtons: 3, numberOfElectrons: 3, numberOfNeutrons: 4),
    PeriodicElement(name: "Beryllium", atomicNumber: 4, numberOfProtons: 4, numberOfElectrons: 4, numberOfNeutrons: 5),
    PeriodicElement(name: "Boron", atomicNumber: 5, numberOfProtons: 5, numberOfElectrons: 5, numberOfNeutrons: 6),
    PeriodicElement(name: "Carbon", atomicNumber: 6, numberOfProtons: 6, numberOfElectrons: 6, numberOfNeutrons: 6),
    PeriodicElement(name: "Nitrogen", atomicNumber: 7, numberOfProtons: 7, numberOfElectrons: 7, numberOfNeutrons: 7),
    PeriodicElement(name: "Oxygen", atomicNumber: 8, numberOfProtons: 8, numberOfElectrons: 8, numberOfNeutrons: 8),
    PeriodicElement(name: "Fluorine", atomicNumber: 9, numberOfProtons: 9, numberOfElectrons: 9, numberOfNeutrons: 10),
    PeriodicElement(name: "Neon", atomicNumber: 10, numberOfProtons: 10, numberOfElectrons: 10, numberOfNeutrons: 10)
    // Add more elements here if needed
]

struct PeriodicElement: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let atomicNumber: Int
    let numberOfProtons: Int
    let numberOfElectrons: Int
    let numberOfNeutrons: Int
}

struct ARViewContainer: UIViewRepresentable {
    let element: PeriodicElement
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        // Generate spheres for protons and neutrons
        createSpheres(for: element.numberOfProtons, color: .red, in: anchor)
        createSpheres(for: element.numberOfNeutrons, color: .green, in: anchor)
        createSpheres(for: element.numberOfElectrons, color: .blue, in: anchor)
        
        arView.scene.addAnchor(anchor)
        
        return arView
    }
    
    /*func updateUIView(_ uiView: ARView, context: Context) {
        uiView.scene.anchors.removeAll()
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        createSpheres(for: element.numberOfProtons, color: .red, in: anchor)
        createSpheres(for: element.numberOfNeutrons, color: .green, in: anchor)
        createSpheres(for: element.numberOfElectrons, color: .blue, in: anchor)
        
        uiView.scene.addAnchor(anchor)
    }*/
    
    private func createSpheres(for count: Int, color: UIColor, in anchor: AnchorEntity) {
        let sphereMesh = MeshResource.generateSphere(radius: 0.05)
        let sphereMaterial = SimpleMaterial(color: color, isMetallic: true)
        
        for i in 0..<count {
            let sphereEntity = ModelEntity(mesh: sphereMesh, materials: [sphereMaterial])
            let xPos = Float(i % 5) * 0.1
            let yPos = Float(i / 5) * 0.1
            sphereEntity.position = [xPos, yPos, 0.0]
            anchor.addChild(sphereEntity)
        }
    }
}

struct ContentView: View {
    @State private var selectedElement = periodicTable[0]
    
    var body: some View {
        VStack {
            Picker("Select an Element", selection: $selectedElement) {
                ForEach(periodicTable, id: \.name) { element in
                    Text(element.name).tag(element)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .padding()
            
            ARViewContainer(element: selectedElement)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    ContentView()
}
    
    /*func makeUIView(context: Context) -> some ARView {
        let arView = ARView(frame: .zero)
        //guard let anchor = try? TestMaty.loadScene() else { return }
        // arView.scene.anchors.append(anchor)
        return arView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // not used
    }*/
    

