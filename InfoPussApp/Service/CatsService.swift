//
//  UserService.swift
//  InfoPussApp
//
//  Created by Juan Harrington on 26/02/23.
//

import Foundation

protocol CatsService{
    func fetchCatsInfo() async throws -> [CatsInfoModel]
}
