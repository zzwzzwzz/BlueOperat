import SwiftUI
import GoogleGenerativeAI

struct ChatMenuView: View {
    @State private var searchText = ""
    @State private var showNewChatView = false
    @State private var selectedTab = 1 // 1 for Chats, 0 for Home, 2 for Favourites, 3 for Activities
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                HomeView()
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
                
                ActivitiesView()
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
    
    @State private var groups: [String] = ["family of hamsters", "random grass group", "rat chat 123"]
    @State private var availableGroups: [String] = ["Cat Clan", "Bird Nest", "Fish Tank", "Fish", "Racoon"]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search", text: $searchText)
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                List(groups, id: \.self) { group in
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
            .navigationTitle("Chats")
            .toolbar {
                Button(action: {
                    showNewChatView = true
                }) {
                    Image(systemName: "square.and.pencil")
                }
            }
            .sheet(isPresented: $showNewChatView) {
                Text("New Chat View Content") // Placeholder
            }
        }
    }
    
    // Helper functions to maintain compatibility with existing chat data
    private func getImageName(for group: String) -> String {
        switch group {
        case "family of hamsters": return "hamsterImage"
        case "random grass group": return "grassImage"
        case "rat chat 123": return "ratImage"
        default: return "defaultImage" // Or a suitable default image name
        }
    }
    
    private func getLastMessage(for group: String) -> String {
        switch group {
        case "family of hamsters": return "Pink Koala: Hey how are we today?"
        case "random grass group": return "You: 🎤 Voice"
        case "rat chat 123": return "Kieron: @adam check it"
        default: return "No messages yet"
        }
    }
    
    private func getUnreadCount(for group: String) -> Int {
        switch group {
        case "family of hamsters": return 99
        case "random grass group": return 0
        case "rat chat 123": return 3
        default: return 0
        }
    }
    
    func leaveGroup(_ group: String) {
        if let index = groups.firstIndex(of: group) {
            groups.remove(at: index)
        }
        
        if let newGroup = availableGroups.randomElement() {
            availableGroups.removeAll { $0 == newGroup }
            groups.append(newGroup)
        }
    }
}


struct MessageModel: Identifiable {
    var id: UUID = UUID()
    var message: String
    var isBot: Bool
    var timestamp: Date = Date()
}



struct ChatRoomView: View {
    let groupName: String
    let onLeaveGroup: () -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var conversation: [MessageModel] = []
    @State private var newMessage: String = ""
    @State private var showLeaveAlert = false
    @State private var navigateToActiveStatus = false //state for navigation

    private let systemPrompt = """
    You are RatBot, a friendly and knowledgeable rat with a passion for both rat-related topics and general conversation. Your personality traits:
        - Uses occasional rat-related puns and metaphors
        - Speaks in a warm, friendly manner
        - Maintains a positive, helpful attitude while staying in character

        Guidelines for responses:
        - Keep responses concise and engaging
        - Do not talk too much
        - Share a random rat fact if they ask for it
        - Be helpful and informative while maintaining the rat persona
        - Never break character but remain professional and helpful
        - Avoid overly cutesy or childish language
        - Like write 1 line rambling on about cheese or stuff whatever the user asks

        Remember: You're a knowledgeable rat assistant helping humans, and you don't talk too much.
    """
    
    var body: some View {
        VStack {
            List {
                ForEach(conversation) { message in
                    MessageBubble(message: message)
                }
            }
            .listStyle(.plain)

            MessageInputView(newMessage: $newMessage, sendMessage: sendMessage)
                .padding(.horizontal)
                .padding(.bottom)
        }
        .navigationTitle(groupName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing){
                Menu {
                    
                    // Leave Group Option
                    Button(role: .destructive) {
                        showLeaveAlert = true
                    } label: {
                        Label("Leave Group", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                    
                    // See Status Option
                    Button {
                        // Action for "See Status"
                        navigateToActiveStatus = true
                    } label: {
                        Label("Active Status", systemImage: "info.circle")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title2)
                        .foregroundColor(.button)
        }
    }
        }

        .alert("Are you sure?", isPresented: $showLeaveAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Leave", role: .destructive) {
                onLeaveGroup()
                presentationMode.wrappedValue.dismiss()
            }
        } message: {
            Text("Do you really want to leave the group?")
        }
        // NavigationLink to ActiveStatusView
                .background(
                    NavigationLink(
                        destination: ActiveStatusView(),
                        isActive: $navigateToActiveStatus,
                        label: { EmptyView() } // Hidden NavigationLink
                    )
                )
    }

    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        
        let messageToSend = newMessage.trimmingCharacters(in: .whitespacesAndNewlines) // Remove extra whitespace
        
        if !messageToSend.isEmpty { // Only send if there's actual content
            conversation.append(MessageModel(message: messageToSend, isBot: false))
            newMessage = ""
            if messageToSend.contains("@ratbot"){
                Task {
                    let response = await GenAI(message: messageToSend)
                    conversation.append(MessageModel(message: response, isBot: true))
                }
            }
        }
    }
    
    func GenAI(message: String) async -> String {
        do {
            let model = GenerativeModel(name: "gemini-1.5-flash-latest", apiKey: "AIzaSyB8H7_PJhXyDIWx8WPQlYJP8QzxNsA13yE")
            
            let fullPrompt = """
            \(systemPrompt)

            User message: \(message)

            Response (maintain rat persona while being helpful):
            """
            
            let resp = try await model.generateContent(fullPrompt)
            let response = resp.text ?? "I squeaked out for a moment there! Could you repeat that?"
            
            print("User said: \(message)")
            print("Response: \(response)")
            
            return response
            
        } catch {
            print("Error occurred: \(error)")
            return "Squeaks! Something went wrong with my whiskers. Could you try again?"
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
        //.padding(.horizontal)
            
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
struct HomeView: View { var body: some View { Text("Home") } }
struct FavouritesView: View { var body: some View { Text("Favourites") } }
struct ActivitiesView: View { var body: some View { Text("Activities") } }


struct ChatMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMenuView()
    }
}
