//
//  LaunchView.swift
//  SwiftUICryptoApp
//
//  Created by m.shirokova on 29.09.2023.
//

import SwiftUI

struct LaunchView: View {
    
    @Binding var showLaunchView: Bool
    
    @State private var loadingText: [String] = "Loading application...".map { String($0) }
    @State private var showLoadingText: Bool = false
    @State private var counter: Int = 0
    @State private var loups: Int = 0
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Color.launchTheme.backgroundColor
                .ignoresSafeArea()
            
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack {
                if showLoadingText {
                    HStack(spacing: 1) {
                        ForEach(loadingText.indices) { idx in
                            Text(loadingText[idx])
                                .font(.headline)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.launchTheme.accentColor)
                                .offset(y: counter == idx ? -5 : 0)
                        }
                    }
                    .transition(AnyTransition.scale.animation(.easeIn))
                }
            }
            .offset(y: 100)
        }
        .onAppear {
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                let lastIndex = loadingText.count - 1
                if counter == lastIndex {
                    counter = 0
                    loups += 1
                    if loups >= 2 {
                        showLaunchView = false
                    }
                } else {
                    counter += 1
                }
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
