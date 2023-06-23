//
//  Network.swift
//  hw2Project
//
//  Created by Jack Liu on 6/22/23.
//

import Foundation
import UIKit
import Combine

class UserService{
    var cancellable = Set<AnyCancellable>()
    let urlString = "https://jsonplaceholder.typicode.com/posts"
    func fetchUser() -> Future<[User], Error>{
        return Future{[weak self] promise in
            guard let self = self else{return}
            guard let url = URL(string: urlString) else{return}
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map{ $0.data }
                .decode(type: [User].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink{completion in
                    switch completion{
                    case .finished:
                        break
                    case .failure(let err):
                        promise(.failure(err))
                    }
                } receiveValue: { response in
                    promise(.success(response))
                }
                .store(in: &self.cancellable)
        }
    }
}
