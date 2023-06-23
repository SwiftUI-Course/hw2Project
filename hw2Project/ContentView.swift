//
//  ContentView.swift
//  hw2Project
//
//  Created by Jack Liu on 6/22/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userModel = ViewModel()
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(spacing:20){
                    ForEach(userModel.userDict.keys.sorted(), id: \.self){ key in
                        NavigationLink(destination: destinationView(key: key)){
                            HStack{
                                Text("User  \(String(key))")
                                    .font(.system(size: 40))
                            }
                        }
                    }
                }
                
                .padding()
            }
            
        }
        .onAppear{userModel.getUser()}
    }
}

struct destinationView: View{
    @StateObject var userModel = ViewModel()
    var key:Int
    var body: some View{
        NavigationView{
            ScrollView{
                VStack{
                    ForEach(userModel.user){ i in
                        if i.userId == key{
                            VStack{
                                Text(i.title)
                                    .font(.system(size: 25)).bold()
                                Divider()
                                Text(i.body)
                            }
                        }
                    }
                    .padding()
                }
            }
            
        }
        .navigationTitle("User \(key) Post")
        .onAppear(perform: userModel.getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
