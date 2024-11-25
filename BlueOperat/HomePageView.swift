//
//  HomePageView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 2024.11.23.
//

import SwiftUI

struct HomePageView: View {
    @State private var searchText = ""
    
    // Example groups data
    let groups: [(name: String, image: String)] = [
        (name: "Family of Hamsters", image: "hamsterImage"),
        (name: "Random Grass Group", image: "grassGroup"),
        (name: "Rat Chat 123", image: "ratsGroup")
    ]
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .top) { // Outer ZStack to control layering
                Image("homeBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .topLeading) // Adjust size as needed
                    .clipped() // Prevent overflow
                    .alignmentGuide(.top) { _ in 0 } // Align to top
                    .alignmentGuide(.leading) { _ in 0 } // Align to left
                    .offset(x: -100, y: -100) // Move it further left (-20) without affecting other alignments
                
                VStack(spacing: 0) {
                    
                    // Main content
                    ScrollView {
                        VStack(spacing: 0) {
                            
                            HStack ( spacing: 0){
                                Text("Be")
                                    .foregroundColor(.black)
                                
                                Text("There")
                                    .foregroundColor(.theme)
                            }
                            .font(.system(size: 40, weight: .bold))
                            .padding(.trailing, 200)
                            .padding(.top, 20)
                            
                        }
                        
                        // Search bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search", text: $searchText)
                        }
                        .padding(.horizontal,16)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding(.horizontal)
                        .frame(height: 36)
                        .shadow(color: Color.black.opacity(0.1), radius: 5)
                        
                        // Your Groups section
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Your Groups")
                                .font(.system(size: 24, weight: .semibold))
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 24) {
                                    ForEach(groups, id: \.name) { group in
                                        NavigationLink(
                                            destination: ChatRoomView(
                                                groupName: group.name,
                                                onLeaveGroup: { print("\(group.name) left.") }
                                            )
                                        ) {
                                            CircularGroupCard(image: group.image, title: group.name)
                                        }
                                    }
                                }
                                .padding(.horizontal, 24)
                            }
                        }
                        .padding(.top, 28)
                        
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
                            .padding(.horizontal, 24)
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .padding(.bottom, -1000) // Pulls the white frame down further
                .padding(.top, 88)
                
                // Rat image overlay
                Image("homeRat")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .padding(.top, 10)
                    .offset(x: 50)
                    .zIndex(1) // Ensures the rat stays on top
            }
            .navigationBarHidden(true)
            .background(Color.theme.opacity(0.6))
            
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
                        Text(title.prefix(1)) // Show the first letter of the title
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
                        .font(.system(size: 16, weight: .semibold))
                    
                    Text("\(date), \(time)")
                        .foregroundColor(.gray)
                        .font(.system(size: 14, weight: .regular))
                    
                    HStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red.opacity(0.8))
                        Text(location)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer() // Ensures the ellipsis button stays to the far right
                
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
        .frame(maxWidth: .infinity) // Makes the card take full width of the container
    }
}

#Preview {
    HomePageView()
}
