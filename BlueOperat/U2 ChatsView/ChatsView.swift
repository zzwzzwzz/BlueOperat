//
//  ChatsView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 2024.11.25.
//

import SwiftUI

struct ChatsView: View {
    @Binding var searchText: String
    @Binding var showNewChatView: Bool
    
    // Fixed array of initial groups
    @State private var groups: [String] = [
        "Family of Hamsters",
        "Random Grass Group",
        "Rat Chat 123"
    ]
    
    // Pool of available groups to rotate in
    @State private var availableGroups: [String] = [
        "Cat Clan",
        "Bird Nest",
        "Fish Tank",
        "Racoon",
        "Hamster Haven",
        "Turtle Team",
        "Bunny Brigade"
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Custom Title
                HStack {
                    Text("Chats")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.horizontal)
                        .padding(.top, 10)
                }
                
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search", text: $searchText)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(20)
                .padding(.horizontal, 20)
                
                // Group list - limited to 3 items
                List(groups.prefix(3), id: \.self) { group in
                    NavigationLink {
                        ChatRoomView(
                            groupName: group,
                            onLeaveGroup: { leaveGroup(group) }
                        )
                    } label: {
                        ChatRow(
                            imageName: getImageName(for: group),
                            groupName: group,
                            lastMessage: getLastMessage(for: group),
                            unreadCount: getUnreadCount(for: group),
                            time: "11:45"
                        )
                    }
                }
                .listStyle(PlainListStyle())
            }
            .navigationBarHidden(true)
        }
    }
    
    // Helper functions for chat data
    private func getImageName(for group: String) -> String {
        switch group {
        case "Family of Hamsters": return "hamsterImage"
        case "Random Grass Group": return "grassImage"
        case "Rat Chat 123": return "ratImage"
        default: return "defaultImage"
        }
    }
    
    private func getLastMessage(for group: String) -> String {
        switch group {
        case "Random Grass Group": return "You: 🎤 Voice"
        case "Rat Chat 123": return "Kieron: @adam check it"
        case "Fish": return "No messages yet"
        default: return "No messages yet"
        }
    }
    
    private func getUnreadCount(for group: String) -> Int {
        switch group {
        case "Random Grass Group": return 0
        case "Rat Chat 123": return 3
        case "Family of Hamsters": return 9
        default: return 0
        }
    }
    
    // Updated leave group function that maintains exactly 3 groups
    func leaveGroup(_ group: String) {
        // Remove the group the user is leaving
        if let index = groups.firstIndex(of: group) {
            groups.remove(at: index)
            
            // Add the removed group back to available groups
            availableGroups.append(group)
            
            // Add a new random group from available groups
            if let newGroupIndex = availableGroups.indices.randomElement() {
                let newGroup = availableGroups.remove(at: newGroupIndex)
                groups.append(newGroup)
            }
            
            // Ensure we maintain exactly 3 groups
            while groups.count > 3 {
                if let lastGroup = groups.last {
                    groups.removeLast()
                    availableGroups.append(lastGroup)
                }
            }
        }
    }
}
