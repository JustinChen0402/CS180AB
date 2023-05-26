//
//  CSVLoader.swift
//  DrZot
//
//  Created by Chris Ruan on 5/23/23.
//

import Foundation
import SwiftCSV


struct FoodData: Identifiable {
    var id = UUID()
    var date: String
    var averageCalories: Double
}

func parseStrDate(strDate: String) -> Date{
    let dateSplit = strDate.components(separatedBy: "/")
    let year = Int(dateSplit[2])
    let month = Int(dateSplit[0])
    let day = Int(dateSplit[1])
    let date: Date! = DateComponents(calendar: Calendar.current, year: year, month: month, day: day).date
    
    return date
}

func parseDateToStr(date: Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/YYYY"
    return dateFormatter.string(from: date)
}


func loadCSVSleepData() -> [SleepData] {
    guard let csvURL = Bundle.main.url(forResource: "/DataFiles/sleep_noNull", withExtension: "csv") else {
        print("Error: Failed to find CSV file")
        return []
    }

    do {
        let csv = try CSV<Named>(url: csvURL)
        let data = csv.rows

        return data.map { row in
            SleepData(date: parseStrDate(strDate:row["Day"]!), averageSleep: Double(row["Sleep(hours)"]!)!)
        }
    } catch {
        print("Error: \(error)")
        return []
    }
}

func loadCSVFoodData() -> [FoodData] {
    guard let csvURL = Bundle.main.url(forResource: "/DataFiles/nutrition_noNull", withExtension: "csv") else {
        print("Error: Failed to find CSV file")
        return []
    }

    do {
        let csv = try CSV<Named>(url: csvURL)
        let data = csv.rows

        return data.map { row in
            
            FoodData(date: row["Date"]!, averageCalories: Double(row["Energy (kcal)"]!)!)
        }
    } catch {
        print("Error: \(error)")
        return []
    }
}
