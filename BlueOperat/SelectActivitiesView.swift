//
//  SelectActivitiesView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 18/11/2024.
//

import SwiftUI

public struct SelectActivitiesView: View {
    @State private var selectedActivities: [String] = []
    
    let activities = [
        "🎨 Art", "🐶 Animals", "💃 Dance", "🧵 DIY",
        "🥘 Food", "🎮 Gaming", "🎬 Movie", "🎶 Music",
        "🏜️ Outdoor", "⚽️ Sports"
    ]
    
    public var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("What activities are you interested in?")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("(Choose 3 only)")
                        .font(.system(size: 16))
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 20)
                }
                .padding(.horizontal, 20)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(activities, id: \.self) { activities in
                        Button(action: {
                            toggleSelection(for: activities)
                        }) {
                            Text(activities)
                                .font(.system(size: 16))
                                .foregroundColor(selectedActivities.contains(activities) ? .white : .black)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(selectedActivities.contains(activities) ? Color.theme : Color.theme.opacity(0.2))
                                .cornerRadius(30)
                        }
                        .disabled(!selectedActivities.contains(activities) && selectedActivities.count >= 3)
                        .padding(.horizontal, 10)
                    }
                }
                .padding(.bottom, 30)
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(30)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
            
            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 12, height: 8)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 12, height: 8)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.theme)
                    .frame(width: 20, height: 8)
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            Button(action: {
                // Next button action
            }) {
                Text("Next")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .background(Color.theme)
            .cornerRadius(30)
            .padding(.horizontal, 40)
            
            Button(action: {
                // Back button action
            }) {
                Text("Back")
                    .font(.system(size: 16))
                    .foregroundColor(Color.subText)
            }
            .padding(.top, 8)
            
            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
    
    private func toggleSelection(for activity: String) {
        if selectedActivities.contains(activity) {
            selectedActivities.removeAll { $0 == activity }
        } else if selectedActivities.count < 3 {
            selectedActivities.append(activity)
        }
    }
}

#Preview {
    SelectActivitiesView()
}
