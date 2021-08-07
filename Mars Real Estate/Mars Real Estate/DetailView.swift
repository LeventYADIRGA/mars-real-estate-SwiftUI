//
//  DetailView.swift
//  DetailView
//
//  Created by Levent YADIRGA on 6.08.2021.
//

import SwiftUI

struct DetailView: View {
    
    let property: MarsProperty
    
    
    var body: some View {
        VStack(spacing: 16){
            AsyncImage(url: URL(string: property.imgSrcUrl)) { image in
                image.resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 220, alignment: .center)
                    .clipped()
            
                
            } placeholder: {
                ProgressView()
                    .frame(height: 220)
            }
            
            VStack(alignment: .leading, spacing: 10){
                Text(property.isRental ? "Kiralık" : "Satılık")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text(String(format: "Fiyat: $%.0f/month", property.price))
                    .font(.title3)
                    .fontWeight(.medium)
            } .frame(maxWidth: .infinity, alignment: .leading)
             
            Spacer()
            
        }.padding()
      
        
    }//: body
    
}



