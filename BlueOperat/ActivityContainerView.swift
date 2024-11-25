//
//  ActivityContainerView.swift
//  BlueOperat
//
//  Created by Ziwen Zhou on 2024.11.25.
//

import SwiftUI

// Main container view to handle navigation
struct ActivityContainerView: View {
    var body: some View {
        NavigationView {
            PastActivityView() // Or whichever view you want to start with
        }
    }
}

// Update the preview to use the container view
#Preview {
    ActivityContainerView()
}
