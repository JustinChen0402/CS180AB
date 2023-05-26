//
//  VarManager.swift
//  DrZot
//
//  Created by Chris Ruan on 4/18/23.
//

import Foundation

class VarManager : ObservableObject {
    static let shared = VarManager()
    
    //Shared sleep data
    //Shared calories data
    //Shared score and recommendation dict
    
    @Published var sleepScore = -1
    @Published var foodScore = -1
    @Published var exerciseScore = -1
    
    @Published var record520 =
    ["You needed way more sleep! Based on the recorded sleep score and sleep time, Dr.Zot found that your sleep time is 54% lower than what your body need. I recommend you to get 7 hr 32 min of sleep",
    "Sleep Score: 44",
     "You had a little too much carbs and fat! Based on the recorded nutrition score and intake food, Dr.Zot found that your carbs intake is 23% higher than what your body need, and 23% higher for fat intake. I recommend you to get 150 grams of carbs and 63 grams of fats per day",
     "Nutrition Score: 72",
     "You are doing great! Keep it going! Based on the recorded exercise score and calories burnt, Dr.Zot found that your calories burnt is within the range of what your body need. To maintain current weight, I recommend you to continue to burn 1300~1600 calories",
     "Exercise Score: 91",
    "Sleep Time: 2 hr 57 min", "Sleep Score: 44", "Calories Intake: 1723 Cal",
     "Nutrition Score: 72", "Calories Burnt: 1438 Cal", "Exercise Score: 91"]

}
