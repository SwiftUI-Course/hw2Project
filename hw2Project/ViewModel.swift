//
//  ViewModel.swift
//  hw2Project
//
//  Created by Jack Liu on 6/22/23.
//
import Foundation
import Combine
import SwiftUI

class ViewModel: ObservableObject{
    @Published var user = [User]()
    @Published var userDict:[Int:[User]] = [:]
    var cancellable = Set<AnyCancellable>()
    let service = UserService()
    
    
    func getUser(){
        service.fetchUser()
            .sink{completion in
                switch completion{
                case .finished:
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }receiveValue: { i in
                self.user = i
                print(self.user)
                self.dataProcess(i)
            }
            .store(in: &cancellable)
    }
    
    func dataProcess(_ data:Array<User>){
        for i in data{
            if userDict[i.userId] == nil{
                userDict[i.userId] = []
                userDict[i.userId]?.append(i)
            }else{
                userDict[i.userId]?.append(i)
            }
        }
    }
    
}
