//
//  HomePageView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 2024.11.23.
//

import SwiftUI

struct HomePageView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .top) { // Outer ZStack to control layering
                VStack(spacing: 0) {
                    // Header with logo and menu
                    VStack(spacing: 0) {
                        HStack {
                            
                            HStack(spacing: 0) {
                                Text("Be")
                                    .foregroundColor(.white)
                                Text("There")
                                    .foregroundColor(.black)
                            }
                            .font(.system(size: 36, weight: .bold))
                            
                            Spacer()
                            
//                            Button(action: {}) {
//                                Image(systemName: "line.horizontal.3")
//                                    .font(.title2)
//                                    .foregroundColor(.white)
//                                    .padding(.top, 10)
//                            }
                        }
                        .padding()
                        .background(Color.theme)
                    }
                    
                    // Main content
                    ScrollView {
                        VStack(spacing: 16) {
                            // Search bar
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                TextField("Search", text: $searchText)
                            }
                            .padding(.horizontal, 15)
                            .padding(.vertical, 8)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .frame(height: 36)
                            .padding(.top, 24)
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                            
                            // Your Groups section
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Your Groups")
                                    .font(.system(size: 28, weight: .semibold))
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 24) {
                                        CircularGroupCard(image: "ratsGroup", title: nil)
                                        CircularGroupCard(image: nil, title: "Rats")
                                        CircularGroupCard(image: "grassGroup", title: nil)
                                    }
                                    .padding(.horizontal, 30)
                                }
                            }
                            
                            // Next Activity section
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Next Activity")
                                    .font(.system(size: 28, weight: .semibold))
                                    .padding(.horizontal)
                                
                                VStack(spacing: 20) {
                                    ActivityCard(
                                        title: "Karaoke City Run",
                                        date: "Friday 28 Nov 2024",
                                        time: "16:00 - 21:00",
                                        location: "Meet at Darling Harbour, W Hotel"
                                    )
                                    
                                    ActivityCard(
                                        title: "Karaoke City Run",
                                        date: "Friday 29 Nov 2024",
                                        time: "16:00 - 21:00",
                                        location: "Meet at Darling Harbour, W Hotel"
                                    )
                                    
                                    ActivityCard(
                                        title: "Mindful and Demure Meditation",
                                        date: "Friday 30 Nov 2024",
                                        time: "11:00 - 13:00",
                                        location: "Meet at Metal Stick and Circle"
                                    )
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    
                    // Tab Bar
                    HStack(spacing: 0) {
                        TabBarItem(icon: "house", text: "Home", isSelected: true)
                        TabBarItem(icon: "bubble.left", text: "Chats", isSelected: false)
                        TabBarItem(icon: "heart", text: "Favourites", isSelected: false)
                        TabBarItem(icon: "calendar", text: "Activities", isSelected: false)
                    }
                    .padding(.top, 10)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, y: -5)
                }
                .navigationBarHidden(true)
                .background(Color.theme)
                
                // Rat image overlay
                Image("homeRat")
                    .resizable()
                    .frame(width: 130, height: 130)
                    .padding(.top, 10)
                    .offset(x: 50)
                    .zIndex(1) // Ensures the rat stays on top
            }
        }
    }
}

// Helper extensions for corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

// HomeTabBarItem component
struct HomeTabBarItem: View {
    let icon: String
    let text: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .foregroundColor(isSelected ? Color.theme : .gray)
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(isSelected ? Color.theme : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}

struct CircularGroupCard: View {
    let image: String?
    let title: String?
    
    var body: some View {
        ZStack {
            if let image = image {
                Image(image)
                    .resizable()
                    .scaledToFill()
            } else if let title = title {
                Circle()
                    .fill(Color.theme.opacity(0.3))
                    .overlay(
                        Text(title)
                            .font(.title3)
                            .foregroundColor(.white)
                    )
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(Circle())
        .shadow(color: Color.black.opacity(0.1), radius: 20)
    }
}

struct ActivityCard: View {
    let title: String
    let date: String
    let time: String
    let location: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 20, weight: .semibold))
                    
                    Text("\(date), \(time)")
                        .foregroundColor(.gray)
                    
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                        Text(location)
                            .foregroundColor(.gray)
                    }
                }
                                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.black)
                        .padding(8)
                }
            }
        }
        .padding()
        .background(Color.theme.opacity(0.1))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 5)
    }
}

#Preview {
    HomePageView()
}
