//
//  FutureActivityView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 2024.11.23.
//

import SwiftUI

struct FutureActivityView: View {
    var body: some View {
        VStack(spacing: 0) {
            ActivityDateHeader(
                day: "29",
                weekday: "Fri",
                month: "Nov",
                year: "2024",
                status: "Today"
            )
            .background(Color.theme)
            
            VStack(spacing: 20) {
                WeekdayHeader(
                    dates: ["26", "27", "28", "29", "30", "1", "2"],
                    selectedDate: "29"
                )
                
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
                
                ScrollView {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .frame(width: 1)
                            .foregroundColor(.theme.opacity(0.2))
                            .offset(x: 72)
                            .frame(maxHeight: .infinity)
                        
                        VStack(spacing: 0) {
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
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.bottom, -1000)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .background(Color.theme)
    }
}

#Preview {
    FutureActivityView()
}
