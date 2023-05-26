//
//  UserSleepDatabase.swift
//  DrZot
//
//  Created by Chris Ruan on 5/23/23.
//

import Foundation

struct SleepData: Identifiable, Codable {
    var id = UUID()
    var date: Date
    var averageSleep: Double
}

extension Date {
    func dayAfter(numberDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: numberDays, to: self)!
    }

    func dayBefore(numberDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: numberDays * -1, to: self)!
    }
}

typealias sleepStorage = Dictionary<Int, Dictionary<Int, Dictionary<Int, SleepData>>>

class UserSleepDatabase : Codable{
    //This class is what gets stored in local storage
    //We want this to be singleton
    
    private var sleepDatabase: Dictionary<Int, Dictionary<Int, Dictionary<Int, SleepData>>> //[Int: [Int: [Int:SleepData]]] //Year -> Month -> Day -> Data
    static public var initialized: Bool = false;
    
    init(){
        assert(!UserSleepDatabase.initialized, "ERROR: UserSleepDatabase has already been created once")
        self.sleepDatabase = Dictionary<Int, Dictionary<Int, Dictionary<Int, SleepData>>>()
        UserSleepDatabase.initialized = true
    }
    
    public func getData(date: Date) -> SleepData{
        //Getter for data
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .day, .month], from: date)
        let year_: Int = components.year!
        let month_: Int = components.month!
        let day_: Int = components.day!
        //if date exists
        if let getYear = self.sleepDatabase[year_], let getMonth = getYear[month_], let getDay = getMonth[day_]{
            return getDay
        }
        //default if date doesn't exist, -1 means not found
        else{
            return SleepData(date: Date(), averageSleep: -1)
        }
        //return self.sleepDatabase[year_]![month_]![day_]!
    }
    
    public func averageSleep(startDate: Date, lastXDays: Int) -> String{
        var average: Double = 0
        var numDays: Int = 0
        for i in 0...lastXDays{
            let workingDay = getData(date: startDate.dayBefore(numberDays: i)).averageSleep
            if workingDay != -1{
                average += workingDay
                numDays += 1
            }
        }
        if numDays != 0{
            return String(format: "%.2f", Float(average)/Float(numDays))
        }
        else{
            return "nil"
        }
        
    }

    
    public func addData(_ date: Date, _ data: SleepData) -> Void{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from : date)
        let year_ : Int = components.year!
        let month_: Int = components.month!
        let day_: Int = components.day!
        
        if (self.sleepDatabase[year_] == nil){
            self.sleepDatabase[year_] = Dictionary<Int, Dictionary<Int, SleepData>>()
        }
        if (self.sleepDatabase[year_]![month_] == nil){
            self.sleepDatabase[year_]![month_] = Dictionary<Int, SleepData>()
        }
        
        self.sleepDatabase[year_]![month_]![day_] = data
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.sleepDatabase)
    }
    
    public required init(from decoder: Decoder) throws {
        //When data already exists in localstorage
        let container = try decoder.singleValueContainer()
        self.sleepDatabase = try container.decode(Dictionary.self)
    }
}
