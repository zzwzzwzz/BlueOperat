//
//  FutureActivityView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 2024.11.23.
//

import SwiftUI

struct FutureActivityView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Blue header with date
                ActivityDateHeader(
                    day: "29",
                    weekday: "Fri",
                    month: "Nov",
                    year: "2024",
                    status: "Today"
                )
                .background(Color.theme)
                
                // Main content
                VStack(spacing: 20) {
                    // Week calendar
                    WeekdayHeader(
                        dates: ["26", "27", "28", "29", "30", "1", "2"],
                        selectedDate: "29"
                    )
                    
                    // Column headers
                    HStack {
                        Text("Time")
                        Text("Activities")
                            .padding(.horizontal,40)
                        Spacer()
                        Image(systemName: "arrow.up.arrow.down")
                    }
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    
                    // Activity slots in a scrollable view
                    ScrollView {
                        ZStack(alignment: .leading) {
                            // Continuous vertical line across all slots
                            Rectangle()
                                .frame(width: 1)
                                .foregroundColor(.theme.opacity(0.2))
                                .offset(x: 72) // Align with time column
                                .frame(maxHeight: .infinity)
                            
                            VStack(spacing: 0) { // Ensure tight spacing between slots
                                ActivityTimeSlot(
                                    startTime: "11:35",
                                    endTime: "13:05",
                                    activity: "Karaoke City Run",
                                    location: "Room 6-205",
                                    organizer: "The Rat Chat",
                                    isPast: false
                                )
                                Spacer()
                                
                                ActivityTimeSlot(
                                    startTime: "13:15",
                                    endTime: "14:45",
                                    activity: "Group Meeting",
                                    location: "Library Room 3",
                                    organizer: "Team Alpha",
                                    isPast: false
                                )
                            }
                        }
                    }
                }
                .padding(.top, 20)
                .background(Color.white)
                .cornerRadius(30, corners: [.topLeft, .topRight])
                .frame(maxHeight: .infinity, alignment: .top) // Keep content pinned to the top
                
                // Tab bar
                HStack(spacing: 0) {
                    TabBarItem(icon: "house", text: "Home", isSelected: false)
                    TabBarItem(icon: "bubble.left", text: "Chats", isSelected: false)
                    TabBarItem(icon: "heart", text: "Favourites", isSelected: false)
                    TabBarItem(icon: "calendar", text: "Activities", isSelected: true)
                }
                .padding(.top, 10)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, y: -5)
            }
            .navigationBarHidden(true)
            .background(Color.theme)
        }
    }
}


#Preview {
    FutureActivityView()
}
