//
//  SelectNewActivity.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 19/11/2024.
//

import SwiftUI

public struct SelectNewActivityView: View {
    @State private var selectedNewActivity: String? = nil
    
    let newActivity = [
        "🎨 Art", "🐶 Animals", "💃 Dance", "🧵 DIY",
        "🥘 Food", "🎮 Gaming", "🎬 Movie", "🎶 Music",
        "🏜️ Outdoor", "⚽️ Sports"
    ]
    
    public var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 8) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("What new activity are you interested in?")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    
                    Text("(Choose 1 only)")
                        .font(.system(size: 16))
                        .foregroundColor(Color.gray)
                        .padding(.bottom, 20)
                }
                .padding(.horizontal, 20)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 30) {
                    ForEach(newActivity, id: \.self) { newActivity in
                        Button(action: { selectedNewActivity = newActivity }) {
                            Text(newActivity)
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(selectedNewActivity == newActivity ? .white : .black)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(selectedNewActivity == newActivity ? Color.theme : Color.theme.opacity(0.2))
                                .cornerRadius(30)
                        }
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
            .padding(.bottom, 40)

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
            
            .padding(.top, 8)
            
            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    SelectNewActivityView()
}
