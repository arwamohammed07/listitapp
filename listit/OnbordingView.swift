//
//  OnbordingView.swift
//  listit!!
//
//  Created by Arwamohammed07 on 13/11/1444 AH.
//

import SwiftUI


enum OnbordingType: CaseIterable {
    case tasks
  //  case voice
    case remind
   
    
    var image: String {
        switch self {
        case .tasks:
            return "1"
//        case .voice:
//            return "2"
        case .remind:
            return "3"
       
        }
    }
    
    var title: String {
        switch self {
        case .tasks:
            return NSLocalizedString("New tasks", comment: "")
            
//        case .voice:
//            return "Voice command"
        case .remind:
            return NSLocalizedString("Remind", comment: "")
            
       
        }
    }
    
//    var description: String {
//        switch self {
//        case .tasks:
//            return "Scan any product barcode with easiest way."
//        case .voice:
//            return "Track your products validity through colors to get the most benefit of it!"
//        case .remind:
//            return "Enable notification to get reminder in your chosen time."
//
//        }
//    }
}


struct OnbordingView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @AppStorage("isUserOnboarded") var isUserOnboarded: Bool = false
    @State var selectedOnbordingType: OnbordingType = .tasks
    
    var body: some View {
        ZStack {
            
            TabView(selection: $selectedOnbordingType) {
                
                ForEach(OnbordingType.allCases, id: \.title) { onbording in
                    SingleOnbordingView(onbordingType: onbording)
                        .tag(onbording)
                        .onChange(of: selectedOnbordingType, perform: { newValue in
                            selectedOnbordingType = newValue
                        })
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            if selectedOnbordingType != .remind {
                skipButton
            }
        }
        .onAppear {
            setupAppearance()
        }
    }
}

struct OnbordingView_Previews: PreviewProvider {
    static var previews: some View {
        OnbordingView()
    }
}

extension OnbordingView {
    var skipButton: some View {
        Button {
            withAnimation(.spring()) {
                isUserOnboarded = true
            }
        } label: {
            Text("skip")
                .padding(10)
        }
        .padding(.top, 1)
        .padding(.trailing)
        .frame(maxWidth: .infinity, alignment: .trailing)
        .frame(maxHeight: .infinity, alignment: .top)
        .foregroundColor(.secondary)
    }
}

extension OnbordingView {
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor =
        colorScheme == .dark ? .white : .black
        UIPageControl.appearance().pageIndicatorTintColor = colorScheme == .dark ? UIColor.white.withAlphaComponent(0.2) : UIColor.black.withAlphaComponent(0.2)
    }
}

