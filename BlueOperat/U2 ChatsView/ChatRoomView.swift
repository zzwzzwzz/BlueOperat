//
//  ChatRoomView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 2024.11.25.
//

import SwiftUI
import GoogleGenerativeAI

struct ChatRoomView: View {
    let groupName: String
    let onLeaveGroup: () -> Void
    @Environment(\.presentationMode) var presentationMode
    @State private var conversation: [MessageModel] = []
    @State private var newMessage: String = ""
    @State private var showLeaveAlert = false
    @State private var navigateToActiveStatus = false
    @State private var navigateToSelectNewActivity = false
    @State private var shouldPopToRoot = false

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
                    Button {
                        navigateToActiveStatus = true
                    } label: {
                        Label("Active Status", systemImage: "info.circle")
                    }
                    
                    Button(role: .destructive) {
                        showLeaveAlert = true
                    } label: {
                        Label("Leave Group", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title2)
                        .foregroundColor(.button)
                }
            }
        }
        .alert("Are you sure?", isPresented: $showLeaveAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Leave", role: .destructive) {
                navigateToSelectNewActivity = true
            }
        } message: {
            Text("Do you really want to leave the group?")
        }
        // Updated NavigationLink syntax for SelectNewActivityView
        .navigationDestination(isPresented: $navigateToSelectNewActivity) {
            SelectNewActivityView(onActivitySelected: {
                onLeaveGroup()
                shouldPopToRoot = true
            })
        }
        // Updated NavigationLink syntax for ActiveStatusView
        .navigationDestination(isPresented: $navigateToActiveStatus) {
            ActiveStatusView()
        }
        // Updated onChange syntax
        .onChange(of: shouldPopToRoot) { _, newValue in
            if newValue {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        
        let messageToSend = newMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !messageToSend.isEmpty {
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
