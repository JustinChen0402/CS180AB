//
//  ContentView.swift
//  DrZot
//
//  Created by Chris Ruan on 2/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingPopover = false
    @State private var isDataActive = false
    @State private var isRecomActive = false
    @State private var date = Date()
    
    var body: some View {
        NavigationView{
            VStack {
                Text("This is place holder for score")
                Text("This is place holder for score graph")
                
                    .padding()
                HStack {
                    Button("Data"){
                        print("tapped")
                        isDataActive = true
                    }
                    
                    Button("Recomendation"){
                        print("tapped")
                        isRecomActive = true
                        
                    }
                    .padding()
                    
                    NavigationLink(destination: DataView(), isActive: $isDataActive) {
                        EmptyView()
                    }
                    
                    NavigationLink(destination: RecommendationView(), isActive: $isRecomActive) {
                        EmptyView()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { // <2>
                ToolbarItem(placement: .principal) { // <3>
                    HStack{
                        Text("Dr. Zot").font(.system(size: 50, weight: .bold, design: .default))
                            
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

        }
        .padding()
    }
}
struct RecommendationView: View {
    @State private var isShowingPopover = false
    @State private var date = Date()
    
    var body: some View {
        Text("Holder for Recommendation")
            .navigationBarTitle("Recommendation")
            .toolbar { // <2>
                ToolbarItem(placement: .principal) { // <3>
                    HStack{
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
    }
}

struct DataView: View {
    
    var body: some View {
        Text("Holder for data")
            .navigationBarTitle("Individual Health Aspects")
        
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
