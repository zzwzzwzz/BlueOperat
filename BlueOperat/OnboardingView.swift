//
//  OnboardingView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 18/11/2024.
//

import SwiftUI

public struct OnboardingView: View {
    public var body: some View {
        VStack(spacing: 20) {
            Spacer() // Push content towards the center
            
            // Add image
            Image("Main")
                .resizable()
                .scaledToFit()
                .frame(height: 350)
                .padding(.horizontal, 40)
            
            Text("Welcome to our\ncommunity!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            Text("Please answer 2 mandatory questions before we add you in group chats. ")
                .font(.subheadline)
                .foregroundColor(Color.subText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 15)
            
            HStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.theme)
                    .frame(width: 20, height: 8)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 12, height: 8)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.4))
                    .frame(width: 12, height: 8)
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
            
            Button(action: {
                // Add Button action
            }) {
                Text("Next")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(Color.button)
            .cornerRadius(30)
            .padding(.horizontal, 40) // Center the button
            
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    OnboardingView()
}
