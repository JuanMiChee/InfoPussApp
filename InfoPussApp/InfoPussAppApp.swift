//
//  InfoPussAppApp.swift
//  InfoPussApp
//
//  Created by Juan Harrington on 26/02/23.
//

import SwiftUI

@main
struct InfoPussAppApp: App {
    let service = URLSessionCatsService()
    var body: some Scene {
        WindowGroup {
            CatsMainView(viewModel: CatsMainViewModel(service: service))
        }
    }
}
