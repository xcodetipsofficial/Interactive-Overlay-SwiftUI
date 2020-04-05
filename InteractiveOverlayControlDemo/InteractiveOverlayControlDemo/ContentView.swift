//
//  ContentView.swift
//  InteractiveOverlayControlDemo
//
//  Created by Kyle Wilson on 2020-01-24.
//  Copyright © 2020 Xcode Tips. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var showOverlay = false
    @State var curColor = Color.blue
    
    var body: some View {
        Text("Hello")
            .frame(width: 100, height: 100)
            .background(curColor)
            .cornerRadius(20)
            .onTapGesture { self.showOverlay.toggle() }
            .overlay(ArcSelectionView(isShowing:
                self.$showOverlay, curColor: self.$curColor))
        
    }
}

struct ArcSelectionView: View {
    @Binding var isShowing: Bool
    @Binding var curColor: Color
    
    let colors = [Color.blue, Color.red, Color.green, Color.yellow]
    
    var body: some View {
        ZStack {
            ForEach(1 ..< 5, id: \.self) { item in
                Circle()
                    .trim(from: self.isShowing ? CGFloat((Double(item) * 0.25) - 0.25) : CGFloat(Double(item) * 0.25), to: CGFloat(Double(item) * 0.25))
                    .stroke(self.colors[item - 1], lineWidth: 30)
                    .frame(width: 300, height: 300)
                    .animation(.linear(duration: 0.4))
                    .onTapGesture {
                        self.curColor = self.colors[item - 1]
                        self.isShowing.toggle()
                }
            }
        }
        .opacity(self.isShowing ? 1: 0)
        .rotationEffect(.degrees(self.isShowing ? 0 : 180))
        .animation(.linear(duration: 0.5))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
