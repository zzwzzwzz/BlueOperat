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
                            
                            Button(action: {}) {
                                Image(systemName: "gearshape")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.top, 10)
                                    .padding(.trailing, 10)
                            }
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
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .frame(height: 36)
                            .padding(.top, 24)
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                            
                            // Your Groups section
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Your Groups")
                                    .font(.system(size: 24, weight: .semibold))
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
                            .padding(.top, 16)
                            
                            // Next Activity section
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Next Activity")
                                    .font(.system(size: 24, weight: .semibold))
                                    .padding(.horizontal)
                                
                                VStack(spacing: 16) {
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
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .padding(.bottom, -1000) // Pulls the white frame down further
                }
//                .navigationBarHidden(true)
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
        .padding(.bottom, 20)
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
