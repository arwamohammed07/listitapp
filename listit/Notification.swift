//
//  Notification.swift
//  listit!!
//
//  Created by Arwamohammed07 on 13/11/1444 AH.
//

//import SwiftUI
//import UserNotifications
//
//
//class NotificationManager{
//    static let instance = NotificationManager()
//
//    func scheduleNotification(hour: Int,minute: Int){
//
//        let center = UNUserNotificationCenter.current()
//
//        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
//        center.requestAuthorization(options: options) { (success, error)in
//            guard error != nil else { return }
//        }
//        let content = UNMutableNotificationContent()
//        content.title = "Task reminder"
//        content.subtitle = "It's time for your task"
//        content.sound = .default
//        content.badge = 0
//
//        var dateComponents = DateComponents()
//        dateComponents.hour = hour
//        dateComponents.minute = minute
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        center.add(request)
//    }
//}
//struct Notification: View {
//    @State var duedate: Date = Date()
//    @State private var isAlertOn = false
//
//    var body: some View {
//        HStack {
//            DatePicker("Alert_" , selection: $duedate)
//                .labelsHidden()
//                .padding(.horizontal)
//            Spacer()
//            Button(action: {
//                let components = Calendar.current.dateComponents([.hour , .minute], from: duedate)
//
//                let hours = components.hour ?? 0
//                let minute = components.minute ?? 0
//
//                NotificationManager.instance.scheduleNotification(hour: hours, minute: minute)
//
//                self.isAlertOn.toggle()
//            }) {
//                Image(systemName: isAlertOn ? "bell.fill" : "bell")
//                    .resizable()
//                    .frame(width: 25, height: 28)
//            }.padding(.trailing)
//
//
//        }.padding(.trailing)
//        .onAppear{
//            UIApplication.shared.applicationIconBadgeNumber = 0
//        }
//    }
//}
//struct Notification_Previews: PreviewProvider {
//    static var previews: some View {
//        Notification()
//    }
//}
