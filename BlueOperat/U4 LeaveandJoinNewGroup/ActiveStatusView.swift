//
//  ActiveStatusView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 19/11/2024.
//

import SwiftUI

struct ActiveStatusView: View {
    @State private var users: [UserProfile] = [
        UserProfile(name: "Blue Quokka", imageUrl: "profile1", hoursLeft: 18, isOnline: true),
        UserProfile(name: "Random Robert", imageUrl: "profile2", hoursLeft: 10, isOnline: false),
        UserProfile(name: "Purple Giraffe", imageUrl: "profile3", hoursLeft: 12, isOnline: false),
        UserProfile(name: "Tobias", imageUrl: "profile4", hoursLeft: 9, isOnline: true),
        UserProfile(name: "Random Karla", imageUrl: "profile5", hoursLeft: 10, isOnline: false),
        UserProfile(name: "Cat Lover", imageUrl: "profile6", hoursLeft: 19, isOnline: false)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Text("Active Status")
                    .font(.system(size: 32, weight: .bold))
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            
            Text("The clock's ticking. Make your move before it's too late!")
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.vertical, 4)
            
            // Main content
            ScrollView {
                VStack(spacing: 8) {

                    // User cards container
                    VStack(spacing: 16) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach($users) { $user in
                                UserCard(user: $user)
                            }
                        }
                    }
                    .padding(16)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
            }
            
            Spacer()
        }
    }
}

struct UserCard: View {
    @Binding var user: UserProfile
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .bottomTrailing) {
                
                // Display the profile image from Assets
                Image(user.imageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
   
                if user.isOnline {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 16, height: 16)
                            .offset(x: -3, y: -3)
                        Circle()
                            .fill(Color.green)
                            .frame(width: 12, height: 12)
                            .offset(x: -3, y: -3)
                    }
                }
            }
            
            Text(user.name)
                .font(.system(size: 16, weight: .medium))
            
            Text("\(user.hoursLeft) hours left to message")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            Button(action: {
                user.isFavorite.toggle()
            }) {
                Image(systemName: user.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(user.isFavorite ? .red : .gray)
                    .imageScale(.medium)
            }
        }
        .padding(10)
    }
}

#Preview {
    ActiveStatusView()
}
