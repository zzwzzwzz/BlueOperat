//
//  CongratulationView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 18/11/2024.
//

import SwiftUI

public struct CongratulationView: View {
    public var body: some View {
        VStack(spacing: 20) { // Add spacing between elements
            Spacer() // Push content towards the center
            
            Text("Congratulations!")
                .font(.custom("SF Pro Text", size: 32))
                .foregroundColor(Color.black)
                .fontWeight(.bold)
                .padding(.bottom, 10) // Padding between title and text
            
            // Add image
            Image("Congratulation")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding(.horizontal, 40)
            
            Text("We’ve found 3 chats for you!")
                .font(.custom("SF Pro Text", size: 24))
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.51, green: 0.78, blue: 0.90))
                .padding(.top, 30)
            
            Text("Start now to make new friends!")
                .font(.custom("SF Pro Text", size: 16))
                .fontWeight(.bold)
                .foregroundColor(Color.subText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Text("You should reply in 24 hours to remain being a part of your group")
                .font(.custom("SF Pro Text", size: 16))
                .foregroundColor(Color.subText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer() // Add space between text and buttons
            
            Button(action: {
                // Add Button action here
            }) {
                Text("Start Chat")
                    .font(.custom("SF Pro Text", size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(Color.button) // Blue button color
            .cornerRadius(30)
            .padding(.horizontal, 50) // Center the button
            
            Button(action: {
                // Add Back action here
            }) {
                Text("Back")
                    .font(.custom("SF Pro Text", size: 16))
                    .foregroundColor(Color(red: 0.61, green: 0.61, blue: 0.61))
            }
            
            Spacer() // Bottom padding
        }
        .background(Color.white)
    }
}

#Preview {
    CongratulationView()
}
