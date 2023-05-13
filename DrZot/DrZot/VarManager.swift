//
//  VarManager.swift
//  DrZot
//
//  Created by Chris Ruan on 4/18/23.
//

import Foundation

class VarManager : ObservableObject {
    static let shared = VarManager()
    
    @Published var sleepScore = 1
    @Published var foodScore = 1
    @Published var exerciseScore = 1

}
