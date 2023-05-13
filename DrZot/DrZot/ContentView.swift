//
//  ContentView.swift
//  DrZot
//
//  Created by Chris Ruan on 4/18/23.
//


import SwiftUI
import SwiftCSV
import SwiftUICharts

struct SleepData: Identifiable {
    var id = UUID()
    var date: String
    var averageSleep: Double
}

struct ContentView: View {
    @State private var isShowingPopover = false
    @State public var date = Date()
    let data = [0.2, 0.5, 0.8, 0.3, 0.6, 0.9, 0.1] //Sub with real data
    
    
    var body: some View {
        
        NavigationView{
            TabView {
                HomeView(date: self.$date)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                RecommendationView(date: self.$date)
                    .tabItem {
                        Label("Recommendation", systemImage: "heart.text.square")
                    }
                AnalysisView()
                    .navigationTitle("Stats Insight")
                    .tabItem {
                        Label("Analysis", systemImage: "chart.bar.fill")
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { // <2>
                ToolbarItem(placement: .principal) { // <3>
                    HStack{
                        Text("DrZot").font(.system(size: 45, weight: .bold, design: .default))
                            .padding(.horizontal,50)
                        Button(action:{self.isShowingPopover = true}){
                            Image(systemName: "calendar")
                                .font(Font.system(.largeTitle))
                        }
                        .popover(isPresented: $isShowingPopover) {
                            DatePicker(
                                "Pick a date to view:",
                                selection: $date,
                                displayedComponents: [.date]
                                
                            )
                            .padding()
                        }
                    }
                    
                }
            }
            .opacity(1)
        }
    }
}


struct HomeView: View {
    @Binding public var date : Date
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 45) {
            
            Text("Summary")
                .font(.title)
                .fontWeight(.ultraLight)
            
            VStack(alignment: .leading, spacing: 45) {
                
                Text("Sleep Score: \(Int(VarManager.shared.sleepScore))")
                    .font(.title)
                    .fontWeight(.ultraLight)
                Text("Food Score: \(Int(VarManager.shared.foodScore))")
                    .font(.title)
                    .fontWeight(.ultraLight)
                Text("Exercise Score: \(Int(VarManager.shared.exerciseScore))")
                    .font(.title)
                    .fontWeight(.ultraLight)
            }
            .padding()
            .cornerRadius(20)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.blue)
            )
        }
    }
}

struct RecommendationView: View {
    
    @State private var showingAddView = false
    @Binding public var date : Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 45) {
            Text("Recommendation")
                .font(.title)
                .fontWeight(.ultraLight)

            VStack(alignment: .leading, spacing: 45) {
    
                Text("Sleep: \(Int(VarManager.shared.sleepScore)) \n(too low!!)")
                    .font(.title)
                    .fontWeight(.ultraLight)
                Text("Food: \(Int(VarManager.shared.foodScore)) \n(too high!!)")
                    .font(.title)
                    .fontWeight(.ultraLight)
                Text("Exercise: \(Int(VarManager.shared.exerciseScore)) \n(That's good enough)")
                    .font(.title)
                    .fontWeight(.ultraLight)
            }
            .padding()
            .cornerRadius(20)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.blue)
                )
        }
        
    }
}

func loadCSVData() -> [SleepData] {
    guard let csvURL = Bundle.main.url(forResource: "/DataFiles/sleep_noNull", withExtension: "csv") else {
        print("Error: Failed to find CSV file")
        return []
    }

    do {
        let csv = try CSV<Named>(url: csvURL)
        let data = csv.rows

        return data.map { row in
            SleepData(date: row["Day"]!, averageSleep: Double(row["Sleep(hours)"]!)!)
        }
    } catch {
        print("Error: \(error)")
        return []
    }
}


struct AnalysisView: View {
    let sleepData = loadCSVData()
    @State private var selectedRange = 0
    
    @State var data2: [Double] = (0..<16).map { _ in .random(in: 9.0...100.0) }
    
    let dateRanges = ["All", "Last Week", "Last Month"]
    
    var filteredSleepData: [SleepData] {
        switch selectedRange {
        case 1:
            return Array(sleepData.suffix(7))
        case 2:
            return Array(sleepData.suffix(30))
        default:
            return sleepData
        }
    }
    
    var yRange: String {
            let minSleep = filteredSleepData.map { $0.averageSleep }.min() ?? 0
            let maxSleep = filteredSleepData.map { $0.averageSleep }.max() ?? 0
            return "(\(minSleep) - \(maxSleep))"
        }
    
    var body: some View {

        ScrollView {
            VStack(spacing: 20) {
                Text("Sleep Data")
                    .font(.largeTitle)
                
                Picker(selection: $selectedRange, label: Text("Date Range")) {
                    ForEach(0 ..< dateRanges.count) {
                        Text(self.dateRanges[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if !filteredSleepData.isEmpty {
                    LineChartView(data: filteredSleepData.map { $0.averageSleep },
                                  title: "Average Sleep",
                                  legend: "Hours " + yRange)
                    .frame(height: 400)
                    LineChartView(data: filteredSleepData.map { $0.averageSleep },
                                  title: "Average Sleep",
                                  legend: "Hours " + yRange)
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

