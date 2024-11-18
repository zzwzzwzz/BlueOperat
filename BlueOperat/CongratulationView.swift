//
//  CongratulationView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 18/11/2024.
//

import SwiftUI

public struct CongratulationView: View {
    public var body: some View {
        VStack(spacing: 16) { // Add spacing between elements
            Spacer() // Push content towards the center
            Text("Congratulations!")
                .font(.largeTitle)
                .foregroundColor(Color.black)
                .fontWeight(.semibold)
                .padding(.bottom, 10)
                .padding(.top, 20)
            
            // Add image
            Image("Congratulation")
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding(.horizontal, 40)
            
            Text("We’ve found 3 chats for you!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.theme)
                .padding(.top, 10)
            
            Text("Start now to make new friends!")
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color.subText)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            Text("You should reply in 24 hours to remain being a part of your group")
                .font(.system(size: 16))
                .foregroundColor(Color.subText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            Button(action: {
                // Add Button action here
            }) {
                Text("Start Chat")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .background(Color.button) // Blue button color
            .cornerRadius(30)
            .padding(.horizontal, 40) // Center the button
            
            Button(action: {
                // Add Back action here
            }) {
                Text("Back")
                    .font(.custom("SF Pro Text", size: 16))
                    .foregroundColor(Color(red: 0.61, green: 0.61, blue: 0.61))
            }
            
            Spacer()
        }
        .background(Color.white)
    }
}

#Preview {
    CongratulationView()
}
