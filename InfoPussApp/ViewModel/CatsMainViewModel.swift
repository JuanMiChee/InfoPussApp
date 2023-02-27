//
//  CatsMainViewModel.swift
//  InfoPussApp
//
//  Created by Juan Harrington on 26/02/23.
//

import Foundation

@MainActor class CatsMainViewModel: ObservableObject {
    
    @Published var viewContent: [CatsViewContent] = [CatsViewContent(origin: "", name: "", intelligence: 0, vetstreet_url: "")]
    
    private let service: CatsService
    
    init(service: CatsService) {
        self.service = service
    }
    
    //getting raw cats data from service, and mapping it to consumible view data.
    func getCats() async {
        do{
            let cats = try await service.fetchCatsInfo()
            
            viewContent = cats.map{
                CatsViewContent(origin: $0.name,
                                name: $0.name,
                                intelligence: $0.intelligence,
                                vetstreet_url: $0.vetstreet_url)
            }
        }
        catch{
            print("error in: \(error.localizedDescription)")
        }
    }
}
