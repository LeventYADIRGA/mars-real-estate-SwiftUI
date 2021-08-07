//
//  ContentView.swift
//  Mars Real Estate
//
//  Created by Levent YADIRGA on 3.08.2021.
//

import SwiftUI

struct ContentView: View {
    
    
    @StateObject private var vm: ViewModel = ViewModel()
    @State private var columns: [GridItem] =  Array(repeating: .init(.flexible()), count: 2)
    @State private var filter: MarsApiFilter = MarsApiFilter.SHOW_ALL
    
    
    private func refresh() async {
        await vm.getProperties(type: filter)
    }
    
    
    
    var body: some View {
        
        NavigationView {
            if vm.status == .LOADING {
                ProgressView()
            }else if vm.status == .DONE{
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        
                        ForEach(vm.properties){ item in
                            NavigationLink {
                                DetailView(property: item)
                            } label: {
                                AsyncImage(url: URL(string: item.imgSrcUrl)) { image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 180, alignment: .center)
                                        .clipped()
                                } placeholder: {
                                    ProgressView().frame(height: 180)
                                }
                            }
                            
                            
                            
                        }
                    }
                    .padding(10)
                }
                .navigationTitle("Mars Emlak")
                .toolbar {
                    ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarLeading) {
                        Menu {
                            Picker(selection: $filter, label: Text("Filter")) {
                                Text("All").tag(MarsApiFilter.SHOW_ALL)
                                Text("Buy").tag(MarsApiFilter.SHOW_BUY)
                                Text("Rent").tag(MarsApiFilter.SHOW_RENT)
                            }
                        }
                    label: {
                        Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    }.onChange(of: filter) { _ in
                        Task {
                            await refresh()
                        }
                            
                    }
                    }
                    
                    ToolbarItemGroup(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        Button{
                            withAnimation (){
                                columns =  Array(repeating: .init(.flexible()), count: columns.count % 3 + 1)
                            }
                            
                        }label:{
                            Image(systemName: "square.grid.2x2")
                        }
                    }
                    
                    
                    
                }
            } else{
                Text("Beklenmeyen bir hata oluştu").foregroundColor(.red)
            }
            
            
        }
        .accentColor(.primary)
//        .onAppear{
//            vm.getProperties(type: filter)
//        }
        .task {
            await vm.getProperties(type: filter)
        }
       
        
    }//: body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
