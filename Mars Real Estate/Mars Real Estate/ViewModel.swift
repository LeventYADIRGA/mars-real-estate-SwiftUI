//
//  ViewModel.swift
//  Mars Real Estate
//
//  Created by Levent YADIRGA on 3.08.2021.
//

import Foundation

enum MarsApiFilter: String {
    case SHOW_RENT = "rent"
    case SHOW_BUY = "buy"
    case SHOW_ALL = "all"
}

enum MarsApiStatus { case LOADING, ERROR, DONE }


//VIEW MODEL
@MainActor
class ViewModel: ObservableObject {
    
    private let BASE_URL = "https://mars.udacity.com/"
    
    @Published private(set) var properties: [MarsProperty] = []
    @Published private(set) var status: MarsApiStatus = .LOADING
    
    
    func getProperties(type: MarsApiFilter) async {
        
        let session = URLSession(configuration: .default)
        let url = URL(string: "\(BASE_URL)realestate?filter=\(type.rawValue)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        self.status = .LOADING
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                self.status = .ERROR
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let results = try decoder.decode([MarsProperty].self, from: data)
                
                self.properties = results
                self.status = .DONE
                print("Sonuç : \(results)")
                
            } catch {
                print("Hata mesajı: \(error)")
                self.status = .ERROR
                
            }
            
        } catch  {
            self.status = .ERROR
            return
        }
        
        
        
    }//: end getProperties
    
    
    //    func getProperties(type: MarsApiFilter){
    //
    //        let session = URLSession(configuration: .default)
    //        let url = URL(string: "\(BASE_URL)realestate?filter=\(type.rawValue)")!
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "GET"
    //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    //
    //        self.status = .LOADING
    //
    //
    //        session.dataTask(with: request) { data, response, error in
    //
    //            if error != nil{
    //                DispatchQueue.main.async {
    //                    self.status = .ERROR
    //                }
    //                return
    //            }
    //     guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
    //           self.status = .ERROR
    //             return
    //             }
    //            let decoder = JSONDecoder()
    //            if let safeData = data {
    //                do {
    //                    let results = try decoder.decode([MarsProperty].self, from: safeData)
    //                    DispatchQueue.main.async {
    //                        self.properties = results
    //                        self.status = .DONE
    //                        print("Sonuç : \(results)")
    //                    }
    //                } catch {
    //                    print("Hata mesajı: \(error)")
    //                    DispatchQueue.main.async {
    //                        self.status = .ERROR
    //                    }
    //                }
    //
    //            }
    //
    //        }.resume()
    //
    //    }//: end getProperties
    //
    
    
    
    
    
    
    
    
    
   
    
    
    
    
    
}
