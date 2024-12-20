//
//  PastActivityView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 2024.11.23.
//

import SwiftUI

// Displays the date header with day, weekday, month, year, and status (e.g., "Past", "Today").
struct ActivityDateHeader: View {
    let day: String
    let weekday: String
    let month: String
    let year: String
    let status: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .bottom, spacing: 8) {
                    // Main day display with weekday and year
                    Text(day)
                        .font(.system(size: 48, weight: .bold))
                    VStack(alignment: .leading) {
                        Text(weekday)
                            .font(.system(size: 16))
                        Text("\(month) \(year)")
                            .font(.system(size: 16))
                    }
                    .padding(.bottom, 10)
                }
            }
            
            Spacer()
            
            // Status badge (e.g., "Past", "Today")
            Text(status)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
                .foregroundColor(.black)
                .cornerRadius(20)
        }
        .padding()
        .foregroundColor(.white)
    }
}

// Displays a horizontal header with weekdays and dates.
// Highlights the selected date with a theme color.
struct WeekdayHeader: View {
    var weekdays = ["S", "M", "T", "W", "T", "F", "S"]
    var dates: [String]
    var selectedDate: String
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<7) { index in
                NavigationLink(destination: {
                    if dates[index] == "28" {
                        PastActivityView() // Navigate to `PastActivityView` for day "28"
                    } else if dates[index] == "29" {
                        FutureActivityView() // Navigate to the current or another view for "29"
                    }
                }) {
                    VStack(spacing: 4) {
                        Text(weekdays[index])
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                        Text(dates[index])
                            .font(.system(size: 16))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background(dates[index] == selectedDate ? Color.theme.opacity(0.2) : Color.clear)
                    .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle()) // Ensure NavigationLink behaves like a button
            }
        }
        .padding(.horizontal)
    }
}


// Displays a time slot with activity details (time, activity name, location, organizer).
// The background color changes based on whether the activity is past or future.
struct ActivityTimeSlot: View {
    let startTime: String
    let endTime: String
    let activity: String?
    let location: String?
    let organizer: String?
    let isPast: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            // Continuous vertical line for alignment
            Rectangle()
                .frame(width: 1)
                .foregroundColor(.black.opacity(0.2))
                .offset(x: 72) // Position to align with time column
                .frame(maxHeight: .infinity)
            
            HStack(alignment: .top, spacing: 24) {
                // Time display column
                VStack(spacing: 4) {
                    Text(startTime)
                        .font(.system(size: 16, weight: .medium))
                    Text(endTime)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                .frame(width: 60, alignment: .leading)
                
                // Activity details
                if let activity = activity {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text(activity)
                                .font(.system(size: 16, weight: .medium))
                            Spacer()
                            // Menu icon
                            Image(systemName: "ellipsis")
                                .foregroundColor(.gray)
                        }
                        
                        // Location details
                        if let location = location {
                            HStack(spacing: 6) {
                                Image(systemName: "mappin")
                                    .foregroundColor(.red)
                                Text(location)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // Organizer details
                        if let organizer = organizer {
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 20, height: 20)
                                Text(organizer)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 20)
                    // Background color changes based on isPast
                    .background(isPast ? Color.black.opacity(0.05) : Color.theme.opacity(0.2))
                    .cornerRadius(16)
                }
            }
            .padding(.horizontal)
        }
    }
}

// Displays a screen for past activities with a scrollable list of time slots.
struct PastActivityView: View {
    var body: some View {
        VStack(spacing: 0) {
            // Date header for "Past" status
            ActivityDateHeader(
                day: "28",
                weekday: "Thu",
                month: "Nov",
                year: "2024",
                status: "Past"
            )
            .background(Color.theme)
            
            // Main content
            VStack(spacing: 20) {
                // Updated WeekdayHeader with navigation
                WeekdayHeader(
                    dates: ["26", "27", "28", "29", "30", "1", "2"],
                    selectedDate: "28"
                )
                
                // Column headers
                HStack {
                    Text("Time")
                    Text("Activities")
                        .padding(.horizontal, 40)
                    Spacer()
                    Image(systemName: "arrow.up.arrow.down")
                }
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .padding(.horizontal)
                
                // Scrollable list of activity time slots
                ScrollView {
                    VStack(spacing: 0) {
                        ActivityTimeSlot(
                            startTime: "11:35",
                            endTime: "13:05",
                            activity: "Mindful and Demure",
                            location: "Metal Stick and Circle",
                            organizer: "Whatever",
                            isPast: true
                        )
                    }
                }
            }
            .padding(.top, 20)
            .background(Color.white)
            .cornerRadius(30, corners: [.topLeft, .topRight])
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.bottom, -1000)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .background(Color.theme)
    }
}

#Preview {
    PastActivityView()
}
