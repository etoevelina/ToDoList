//
//  toDoItemVIew.swift
//  ToDoList
//
//  Created by Эвелина Пенькова on 24.08.2024.
//

import SwiftUI

struct ToDoItemVIew: View {
    var item: Item
    var title: String
    var descrition: String
    var timestamp: Date
    var status: Bool
    
    
    var body: some View {
        ZStack{
            Rectangle()
            .frame(width: 160, height: 160)
            .foregroundColor(.white)
            .cornerRadius(10)
            .shadow(color: Color(red: 0, green: 0, blue: 0).opacity(0.25), radius: 2, x: 4, y: 7)
            .overlay(
            RoundedRectangle(cornerRadius: 10)
            .inset(by: -1)
            .stroke(Color(red: 0, green: 0, blue: 0), lineWidth: 2)
            )
            VStack(){
                HStack {
                    Text("🗓️ \(timestamp, formatter: itemFormatter)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                    if status {
                        ZStack{
                            Ellipse()
                                .strokeBorder(
                                   style: StrokeStyle(
                                       lineWidth: 1,
                                       lineCap: .round,
                                       dash: [5]
                                   )
                               )
                               .foregroundColor(Color(red: 0.02, green: 0.59, blue: 0.22))
                                .frame(width: 26, height: 26)
                            
                            Image(systemName: "clock.badge.checkmark")
                                .foregroundColor(Color(red: 0.02, green: 0.59, blue: 0.22))
                                .frame(width: 17, height: 17)
                        }
                    } else {
                        ZStack{
                            Ellipse()
                                .strokeBorder(
                                   style: StrokeStyle(
                                       lineWidth: 1,
                                       lineCap: .round,
                                       dash: [5]
                                   )
                               )
                               .foregroundColor(Color(red: 0.55, green: 0, blue: 1))
                                .frame(width: 26, height: 26)
                            
                            Image(systemName: "clock.arrow.circlepath")
                                .foregroundColor(Color(red: 0.55, green: 0, blue: 1))
                                .frame(width: 17, height: 17)
                        }
                    }
                }
                if !title.isEmpty {
                    Text(title)
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 130, height: 78)
                } else {
                    Text(descrition)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: 130, height: 78)
                        .padding(.horizontal)
                }
            }
            
        }.frame(width: 160, height: 160)
            .padding()
        
    }
}
