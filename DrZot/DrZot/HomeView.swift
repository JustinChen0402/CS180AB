//
//  HomeView.swift
//  DrZot
//
//  Created by Chris Ruan on 5/23/23.
//

import SwiftUI

struct HomeView: View {
    @Binding public var date : Date
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Summary - " + parseDateToStr(date: date))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20)
                if(parseDateToStr(date: date) == "05/20/2023"){
                    BoxView(subtitle: "Sleep",
                            textLine1: VarManager.shared.record520[6],
                            textLine2: VarManager.shared.record520[7],
                            imageName: "bed.double.fill")

                    BoxView(subtitle: "Nutrition",
                            textLine1: VarManager.shared.record520[8],
                            textLine2: VarManager.shared.record520[9],
                            imageName: "fork.knife")
                    
                    BoxView(subtitle: "Exercise",
                            textLine1: VarManager.shared.record520[10],
                            textLine2: VarManager.shared.record520[11],
                            imageName: "dumbbell.fill")
                }
                else{
                    
                    BoxView(subtitle: "Sleep",
                            textLine1: "Sleep Time: -1",
                            textLine2: "Sleep Score: \(Int(VarManager.shared.sleepScore))",
                            imageName: "bed.double.fill")
                    
                    BoxView(subtitle: "Nutrition",
                            textLine1: "Calories Intake: -1",
                            textLine2: "Nutrition Score: \(Int(VarManager.shared.foodScore))",
                            imageName: "fork.knife")
                    
                    BoxView(subtitle: "Exercise",
                            textLine1: "Calories Burnt: -1",
                            textLine2: "Exercise Score: \(Int(VarManager.shared.exerciseScore))",
                            imageName: "dumbbell.fill")
                }
            }
            .padding(.all, 20)
        }
    }
}


struct BoxView: View {
    let subtitle: String
    let textLine1: String
    let textLine2: String
    let imageName: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(subtitle)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            HStack {
                Image(systemName: imageName)
                    .font(.title2)
                    .foregroundColor(.blue)
                
                Spacer()
                
                
                VStack(alignment: .leading) {
                    Text(textLine1)
                        .font(.body)
                    Text(textLine2)
                        .font(.body)
                }
            }
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .padding(.bottom, 20)
    }
}
