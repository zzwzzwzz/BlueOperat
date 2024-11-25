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
                
                FutureActivityView()
                    .tabItem {
                        Label("Activities", systemImage: "leaf")
                    }
                    .tag(3)
            }
            .accentColor(.button)
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
struct FavouritesView: View { var body: some View { Text("Favourites") } }

struct ChatMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMenuView()
    }
}
