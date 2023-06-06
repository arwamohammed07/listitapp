//
//  SingleOnbordingView.swift
//  listit!!
//
//  Created by Arwamohammed07 on 13/11/1444 AH.
//

import SwiftUI

struct SingleOnbordingView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isUserOnboarded") var isUserOnboarded: Bool = false
    let onbordingType: OnbordingType
    
    var body: some View {
        
        VStack(spacing:20) {
            Image(colorScheme == .light ? onbordingType.image : onbordingType.image + "_dark")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
            
            Text(onbordingType.title)
                .font(.title).bold()
            
//            Text(onbordingType.description)
//                .multilineTextAlignment(.center)
//                .foregroundColor(.secondary)
            
            if onbordingType == .remind {
                Button {
                    withAnimation(.spring()) {
                        isUserOnboarded = true
                    }
                } label: {
                    Text("Get Started")
                        .font(.headline)
                        .padding()
                        .foregroundColor(colorScheme == .light ? .white : .black)
                        .frame(width: 300, height: 50)
                        .background(Color.accentColor)
                        .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                
            }

        }
        .padding(.horizontal,40)
        
        
    }
}

struct SingleOnbordingView_Previews: PreviewProvider {
    static var previews: some View {
        SingleOnbordingView(onbordingType: OnbordingType.tasks)
    }
}
