//
//  ContentView.swift
//  DrZot
//
//  Created by Chris Ruan on 4/18/23.
//


import SwiftUI

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
                AnalysisView(date: self.$date, data: data)
                    .frame(height: 200)
                    .padding()
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
        .padding()
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

struct AnalysisView: View {
    
    @State private var showingAddView = false
    @Binding public var date : Date
    let data: [Double]
    
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
            HStack(alignment: .bottom, spacing: 16) {
                ForEach(data.indices, id: \.self) { index in
                    VStack {
                        Spacer()
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: (geometry.size.width - CGFloat(data.count * 16)) / CGFloat(data.count),
                                    height: CGFloat(data[index]) * geometry.size.height)
                        }
                    }
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

