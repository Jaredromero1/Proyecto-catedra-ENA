//
//  ViewController.swift
//  App_Ena
//
//  Created by Jared Romero on 10/10/24.
//

import Foundation

class DataLoader: ObservableObject {
    static let shared = DataLoader()
    
    var lessons: [Lesson] = []
    
    init() {
        loadJSONData()
    }
    
    func loadJSONData() {
        if let url = Bundle.main.url(forResource: "Data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(DataModel.self, from: data)
                self.lessons = decodedData.lessons
            } catch {
                print("Erro al cargar los datos: \(error)")
            }
        } else {
            print("No se encontrararon los datos")
        }
    }
}
