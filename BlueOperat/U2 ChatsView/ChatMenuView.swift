import SwiftUI
import GoogleGenerativeAI

struct ChatMenuView: View {
    @State private var searchText = ""
    @State private var showNewChatView = false
    @State private var selectedTab = 1 // 1 for Chats, 0 for Home, 2 for Favourites, 3 for Activities
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                HomePageView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                    .tag(0)
                
                ChatsView(searchText: $searchText, showNewChatView: $showNewChatView)
                    .tabItem {
                        Label("Chats", systemImage: "message")
                    }
                    .tag(1)
                
                FavouritesView()
                    .tabItem {
                        Label("Favourites", systemImage: "heart")
                    }
                    .tag(2)
                
                ActivityContainerView()
                    .tabItem {
                        Label("Activities", systemImage: "leaf")
                    }
                    .tag(3)
            }
            .accentColor(.button)
        }
    }
}

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

struct MessageBubble: View {
    let message: MessageModel

    var body: some View {
        HStack {
            if !message.isBot { Spacer() }
            
            VStack(alignment:  message.isBot ? .trailing : .leading) {
                if message.message == "Message was deleted." {
                    Text(message.message)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2).cornerRadius(10))
                } else {
                    Text(message.message)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(message.isBot ? Color(uiColor: .systemGray5) : Color.button)
                        .cornerRadius(16)
                    
                    Text(message.timestamp, style: .time)
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
            }
            if message.isBot { Spacer() }
        }
        .listRowSeparator(.hidden)
        .padding(.horizontal)
            
    }
}

struct MessageInputView: View {
    @Binding var newMessage: String
    var sendMessage: () -> Void
    
    var body: some View {
        HStack {
            TextField("Type a message...", text: $newMessage)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color(uiColor: .systemGray6))
                .cornerRadius(16)
            
            Button(action: sendMessage) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.button)
            }
        }.padding(.top)
    }
}

struct ChatRow: View {
    let imageName: String
    let groupName: String
    let lastMessage: String
    let unreadCount: Int
    let time: String
    var hasMentions: Bool = false
    
    var body: some View {
        HStack {
            // Support both image and placeholder
            if UIImage(named: imageName) != nil {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 50, height: 50)
                    .overlay(Text(groupName.prefix(1)))
            }
            
            VStack(alignment: .leading) {
                Text(groupName)
                    .font(.headline)
                HStack {
                    if hasMentions {
                        Image(systemName: "at")
                    }
                    Text(lastMessage)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(time)
                    .font(.caption)
                    .foregroundColor(.gray)
                if unreadCount > 0 {
                    Text("\(unreadCount)")
                        .font(.caption)
                        .padding(5)
                        .background(Color.button)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.vertical, 8)
    }
}

// Placeholder Views
struct FavouritesView: View { var body: some View { Text("Favourites") } }

struct ChatMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMenuView()
    }
}
