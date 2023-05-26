//
//  RecommendationView.swift
//  DrZot
//
//  Created by Chris Ruan on 5/23/23.
//

import SwiftUI

struct RecommendationView: View {
    
    @State private var showingAddView = false
    @Binding public var date : Date
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Recommendation - " + parseDateToStr(date: date))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                if(parseDateToStr(date: date) == "05/20/2023"){
                    BoxView(subtitle: "Sleep",
                            textLine1: VarManager.shared.record520[0],
                            textLine2: VarManager.shared.record520[1],
                            imageName: "bed.double.fill")

                    BoxView(subtitle: "Nutrition",
                            textLine1: VarManager.shared.record520[2],
                            textLine2: VarManager.shared.record520[3],
                            imageName: "fork.knife")
                    
                    BoxView(subtitle: "Exercise",
                            textLine1: VarManager.shared.record520[4],
                            textLine2: VarManager.shared.record520[5],
                            imageName: "dumbbell.fill")
                }
                else{
                    
                    BoxView(subtitle: "Sleep",
                            textLine1: "No data provided for this date",
                            textLine2: "Sleep Score: \(Int(VarManager.shared.sleepScore))",
                            imageName: "bed.double.fill")
                    
                    BoxView(subtitle: "Nutrition",
                            textLine1: "No data provided for this date",
                            textLine2: "Nutrition Score: \(Int(VarManager.shared.foodScore))",
                            imageName: "fork.knife")
                    
                    BoxView(subtitle: "Exercise",
                            textLine1: "No data provided for this date",
                            textLine2: "Exercise Score: \(Int(VarManager.shared.exerciseScore))",
                            imageName: "dumbbell.fill")
                }
            }
            .padding(.all, 20)
        }
    }
}
