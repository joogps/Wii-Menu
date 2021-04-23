//
//  CursorView.swift
//  Wii Menu
//
//  Created by João Gabriel Pozzobon dos Santos on 22/04/21.
//

import SwiftUI

struct CursorView: View {
    var body: some View {
        ZStack {
            Image(systemName: "hand.point.up.fill").overlay(
            LinearGradient(gradient: Gradient(colors: [Color.white, Color(#colorLiteral(red: 0.2673085034, green: 0.5788834691, blue: 0.9655111432, alpha: 1))]), startPoint: UnitPoint(x: 0.5, y: 0.6), endPoint: .bottom).mask(Image(systemName: "hand.point.up.fill")))
            
            Image(systemName: "hand.point.up")
                .foregroundColor(.black)
            
            Text("1").font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundColor(Color(#colorLiteral(red: 0.2196078431, green: 0.5450980392, blue: 0.968627451, alpha: 1)))
                .offset(x: 3, y: 10)
        }.font(.system(size: 56, weight: .light))
    }
}

struct CursorView_Previews: PreviewProvider {
    static var previews: some View {
        CursorView()
    }
}
