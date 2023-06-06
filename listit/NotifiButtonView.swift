//
//  NotifiButtonView.swift
//  listit!!
//
//  Created by Arwamohammed07 on 13/11/1444 AH.
//

//import SwiftUI
//
//struct NotifiButtonView: View {
//    @State private var isLiked = false
//
//    var body: some View {
//       VStack {
//      //      Text(isLiked ? "Liked!": "Unliked!")
//           HeartButton(isClicked: $isLiked)
//       }
//   }
//}
//struct HeartButton: View {
//    @Binding var isClicked: Bool
//    
//    private let animationDuration: Double = 0.1
//    private var animationScale: CGFloat {
//        isClicked ? 0.7 : 1.3
//    }
//    
//    @State private var animate = false
//    
//    var body: some View {
//        Button(action: {
//            self.animate = true
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration, execute: {
//                self.animate = false
//                self.isClicked.toggle()
//            })
//        }, label: {
//            Image (systemName: isClicked ? "bell.fill" : "bell")
//                .resizable()
//                .aspectRatio (contentMode: .fit)
//                .frame(width: 25)
//                .foregroundColor (isClicked ? (Color.accentColor) : (Color.accentColor))
//        })
//        .scaleEffect (animate ? animationScale : 1)
//        .animation (.easeIn(duration: animationDuration))
//    }
//}
//        struct LikeButtonView_Previews: PreviewProvider {
//            static var previews: some View {
//        NotifiButtonView()
//    }
//}
