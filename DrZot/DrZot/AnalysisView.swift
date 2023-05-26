//
//  AnalysisView.swift
//  DrZot
//
//  Created by Chris Ruan on 5/23/23.
//

import SwiftUI
import SwiftUICharts

struct AnalysisView: View {
    let sleepData = loadCSVSleepData()
    @State private var selectedRange = 0
    let foodData = loadCSVFoodData()
    
    let dateRanges = ["Last Year", "Last Week", "Last Month"]
    
    var filteredSleepData: [SleepData] {
        switch selectedRange {
        case 1:
            return Array(sleepData.suffix(7))
        case 2:
            return Array(sleepData.suffix(30))
        default:
            return Array(sleepData.suffix(365))
        }
    }
    var filteredFoodData: [FoodData] {
        switch selectedRange {
        case 1:
            return Array(foodData.suffix(7))
        case 2:
            return Array(foodData.suffix(30))
        default:
            return Array(foodData.suffix(365))
        }
    }
    
    var ySleepRange: String {
            let minSleep = filteredSleepData.map { $0.averageSleep }.min() ?? 0
            let maxSleep = filteredSleepData.map { $0.averageSleep }.max() ?? 0
            return "(\(minSleep) - \(maxSleep))"
        }
    var yFoodRange: String {
            let minFood = filteredFoodData.map { $0.averageCalories }.min() ?? 0
            let maxFood = filteredFoodData.map { $0.averageCalories }.max() ?? 0
            return "(\(minFood) - \(maxFood))"
        }
    
    var body: some View {

        ScrollView {
            VStack(spacing: 20) {
                
                Picker(selection: $selectedRange, label: Text("Date Range")) {
                    ForEach(0 ..< dateRanges.count) {
                        Text(self.dateRanges[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if !filteredSleepData.isEmpty {
                    LineView(data: filteredSleepData.map { $0.averageSleep },
                                  title: "Avg. Sleep",
                                  legend: "Hours " + ySleepRange)
                    .frame(height: 400)
                    LineView(data: filteredFoodData.map { $0.averageCalories },
                                  title: "Avg. Calories",
                                  legend: "kCal " + yFoodRange)
                    .frame(height: 400)
                    
                } else {
                    Text("No data available.")
                }
            }
            .padding(.horizontal)
            .padding(.top, 20)
            .padding(.bottom, 50)
        }
    }
}
