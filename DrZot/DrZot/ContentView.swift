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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

