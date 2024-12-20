//
//  SelectNewActivity.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 19/11/2024.
//

import SwiftUI

struct SelectNewActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedNewActivity: String? = nil
    var onActivitySelected: () -> Void
    
    let newActivity = [
        "🎨 Art", "🐶 Animals", "💃 Dance", "🧵 DIY",
        "🥘 Food", "🎮 Gaming", "🎬 Movie", "🎶 Music",
        "🏜️ Outdoor", "⚽️ Sports"
    ]
    
    var body: some View {
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
                    ForEach(newActivity, id: \.self) { activity in
                        Button(action: { selectedNewActivity = activity }) {
                            Text(activity)
                                .font(.system(size: 16))
                                .fontWeight(.regular)
                                .foregroundColor(selectedNewActivity == activity ? .white : .black)
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .background(selectedNewActivity == activity ? Color.theme : Color.theme.opacity(0.2))
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
                if selectedNewActivity != nil {
                    onActivitySelected()
                    presentationMode.wrappedValue.dismiss()
                }
            }) {
                Text("Next")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .background(selectedNewActivity != nil ? Color.theme : Color.theme.opacity(0.2))
            .disabled(selectedNewActivity == nil)
            .cornerRadius(30)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
}

#Preview {
    SelectNewActivityView(onActivitySelected: {})
}
